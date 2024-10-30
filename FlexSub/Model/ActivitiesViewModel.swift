//
//  Catalog.swift
//  FlexSub
//
//  Created by Apprenant 108 on 25/10/2024.
//

import Foundation
import Combine
import FirebaseFirestore


@Observable class ActivitiesViewModel {
    var activities : [Activity] = Activity.sampleData()
    var activitiesState: RequestState<[Activity]> = .idle
    var searchText: String = ""
    var selectedCategory: Category = .all

    // local
    var filteredActivities: [Activity] {
           activities.filter { activity in
               (selectedCategory == .all || activity.category == selectedCategory) &&
               (searchText.isEmpty || activity.title.lowercased().contains(searchText.lowercased()))
           }
       }
    
    

       func addActivity(activity: Activity) {
           activities.append(activity)
           addActivityToFirestore(activity: activity)
       }

       func myActivities(userId: String) -> [Activity] {
           activities.filter { $0.ownerId == userId }
       }
    
   // Firebase
    func addActivityToFirestore(activity: Activity) {
            do {
                // Encode l'activité complète avec l'adresse incluse
                let activityData = try Firestore.Encoder().encode(activity)
                
                FirebaseManager.shared.db.collection("activities").document(activity.id).setData(activityData) { error in
                    if let error = error {
                        print("Erreur lors de l'ajout de l'activité : \(error.localizedDescription)")
                    } else {
                        print("Activité et adresse ajoutées avec succès !")
                    }
                }
            } catch {
                print("Erreur lors de l'encodage de l'activité : \(error.localizedDescription)")
            }
        }
    
    func fetchMyActivities(for userId: String) {
        
        FirebaseManager.shared.db.collection("activities")
            .whereField("ownerId", isEqualTo: userId)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Erreur lors de la récupération des activités : \(error.localizedDescription)")
                    return
                }

                guard let documents = snapshot?.documents else {
                    print("Aucun document trouvé pour cet utilisateur.")
                    return
                }

                // Décoder les activités récupérées
                do {
                    self.activities = try documents.compactMap { document in
                        try document.data(as: Activity.self)
                    }
                    print("Activités de l'utilisateur récupérées avec succès !")
                } catch {
                    print("Erreur lors du décodage des activités : \(error.localizedDescription)")
                }
            }
    }
    
    func fetchActivities(userId: String, date: Date? = nil, query: String? = nil, status: String = Status.published.rawValue) async {
            activitiesState = await RequestManager.shared.perform {
                return try await withCheckedThrowingContinuation { continuation in
                    var dbQuery: Query = FirebaseManager.shared.db.collection("activities")
                        .whereField("status", isEqualTo: status)
                        .whereField("ownerId", isNotEqualTo: userId)
                    
                    if let date = date {
                        let timestamp = Timestamp(date: date)
                        dbQuery = dbQuery.whereField("date", isEqualTo: timestamp)
                    }
                    
                    if let query = query, !query.isEmpty {
                        dbQuery = dbQuery.whereField("title", isGreaterThanOrEqualTo: query)
                            .whereField("title", isLessThan: query + "\u{f8ff}")
                    }
                    
                    dbQuery.getDocuments { snapshot, error in
                        if let error = error {
                            continuation.resume(throwing: error)
                            return
                        }
                        
                        guard let documents = snapshot?.documents else {
                            continuation.resume(throwing: FirebaseError.noDocuments)
                            return
                        }
                        
                        let activities = documents.compactMap { doc -> Activity? in
                            try? doc.data(as: Activity.self)
                        }
                        
                        if activities.isEmpty {
                            continuation.resume(throwing: FirebaseError.noDocuments)
                        } else {
                            continuation.resume(returning: activities)
                        }
                    }
                }
            }
            
            // Mettre à jour les activities si la requête est réussie
            if case .success(let fetchedActivities) = activitiesState {
                self.activities = fetchedActivities
            }
        }
}


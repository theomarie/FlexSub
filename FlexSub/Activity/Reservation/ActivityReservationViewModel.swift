//
//  ActivityReservationViewModel.swift
//  FlexSub
//
//  Created by Theo Marie on 05/11/2024.
//
import Foundation
import Combine
import FirebaseFirestore

@Observable class ActivityReservationViewModel {
    var activity : Activity
    var activitiyState: RequestState<Activity> = .idle
    
    init(activity: Activity, activitieState: RequestState<Activity>) {
        self.activity = activity
        self.activitiyState = activitiyState
    }
    
    
    func joinActivity(userID: String, activityID: String) async {
           activitiyState = .loading
           let db = FirebaseManager.shared.db.collection("activities").document(activityID)
           
           do {
               // Ajouter l'ID de l'utilisateur à participantIDs et mettre le statut à "inProgress" dans Firestore
               try await db.updateData([
                "participantid": userID,
                   "status": Status.inProgress.rawValue
               ])
               
               // Met à jour localement l'activité pour refléter les modifications
               activity.participantid = userID
               activity.status = .inProgress
               activitiyState = .success(activity)
               
               print("L'utilisateur \(userID) a rejoint l'activité \(activityID) avec succès !")
               
           } catch {
               // Gère l'erreur et met à jour l'état en erreur
               activitiyState = .error(error)
               print("Erreur lors de la tentative de rejoindre l'activité : \(error.localizedDescription)")
           }
       }
    
}

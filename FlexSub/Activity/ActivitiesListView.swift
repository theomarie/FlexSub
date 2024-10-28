//
//  ActivitiesListView.swift
//  FlexSub
//
//  Created by Apprenant 82 on 24/10/2024.
//

import SwiftUI




// Liste des activités
let activities: [Activity] = [
    Activity(title: "Terrifier 3", status: .published, owner: user1, participant: nil, price: 10.50, date: Date(), category: .cinema, etablissement: etablissementPathe, location: "Cinéma Pathé, Paris", distance: 2.5),
    Activity(title: "Seance de sport", status: .published, owner: user2, participant: nil, price: 15.0, date: Date(), category: .sport, etablissement: etablissementBasicFit, location: "Stade de France, Paris", distance: 3.0),
    Activity(title: "Expo Van Gogh", status: .published, owner: user3, participant: nil, price: 12.0, date: Date(), category: .museum, etablissement: etablissementMadParis, location: "Musée d'Orsay, Paris", distance: 1.5),
    Activity(title: "Concert Electro", status: .published, owner: user4, participant: nil, price: 25.0, date: Date(), category: .concert, etablissement: etablissementTempMachines, location: "Salle Pleyel, Paris", distance: 2.0),
]

struct ActivitiesListView: View {
    @State private var selectedCategory: Category = .all

    var filteredActivities: [Activity] {
        if selectedCategory == .all {
            return activities
        } else {
            return activities.filter { $0.category == selectedCategory }
        }
    }

    var body: some View {
        VStack {
            Picker("Catégorie", selection: $selectedCategory) {
                ForEach(Category.allCases) { category in
                    Text(category.rawValue).tag(category)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            List(filteredActivities) { activity in
                ActivityView(activity: activity)
            }
            .listStyle(PlainListStyle())
        }
    }
}

#Preview {
    ActivitiesListView()
}

import SwiftUI

struct SearchableActivitiesView: View {
    @State private var selectedCategory: Category = .all
    @State private var searchText: String = ""
    @State var activitiesViewModel = ActivitiesViewModel()
  
    var filteredActivities: [Activity] {
        activitiesViewModel.activities.filter { activity in
            
            (selectedCategory == .all || activity.category == selectedCategory) &&
            
            (searchText.isEmpty ||
             activity.title.lowercased().contains(searchText.lowercased()))
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

            // Barre de recherche
            TextField("Rechercher une activité ou un établissement", text: $searchText)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)

        
            List(filteredActivities) { activity in
                ActivityRow(activity: activity)
            }
            .listStyle(PlainListStyle())
        }
        .padding(.vertical)
    }
}




#Preview {
    let activitiesViewModel = ActivitiesViewModel()
    SearchableActivitiesView(activitiesViewModel: activitiesViewModel)
}

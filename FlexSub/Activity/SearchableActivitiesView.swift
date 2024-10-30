import SwiftUI

struct SearchableActivitiesView: View {
    @Bindable var activitiesViewModel: ActivitiesViewModel
    
   
    
    var body: some View {
        VStack {
            TextField("Rechercher une activité ou un établissement", text: $activitiesViewModel.searchText)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
        }
    }
}




#Preview {
    let activitiesViewModel = ActivitiesViewModel()
    SearchableActivitiesView(activitiesViewModel: activitiesViewModel)
}

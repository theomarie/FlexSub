import SwiftUI

struct ActivityRow: View {
    var activity: Activity

    var body: some View {
        HStack {
            // Affiche le logo : ressource || SF Symbol
                       if let uiImage = UIImage(named: activity.logo) {
                           Image(uiImage: uiImage)
                               .resizable()
                               .scaledToFit()
                               .frame(width: 60, height: 60) // voir comment ne pas mettre la taille de l'image en dur
                               .cornerRadius(8)
                       } else {
                           Image(systemName: activity.logo) // Utilise SF Symbol
                               .resizable()
                               .scaledToFit()
                               .frame(width: 60, height: 60) // Possible reduire le code logique
                               .cornerRadius(8)
                       }
             
            VStack(alignment: .leading, spacing: 4) {
              
                HStack {
                    Text(activity.title)
                        .font(.headline)
                    Spacer()
                    Text(formatDate(activity.date))
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.black)
                        .cornerRadius(10)
                }

              
                Text(activity.address.streetAddress)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

               
                HStack {
                    Text(activity.address.formattedAddress)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("\(String(format: "%.2f", activity.price))€")
                        .font(.headline)
                        .fontWeight(.bold)
                }
            }
        }
        .padding(.vertical, 8)
    }

    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm" 
        return formatter.string(from: date)
    }
}


let ownerUser = User(
    id: UUID().uuidString,
    username: "Stéphane",
    email: "Dupont",
    firstName: "stephane@example.com",
    lastName: "password123",
    profileImageUrl: "",
    address: "123 rue de paris"
)

let cinemaActivity = Activity(
    id: UUID().uuidString,
    title: "Terrifier 3",
    status: .published,
    ownerId: ownerUser.id,
    price: 10.50,
    date: Date(),
    category: .cinema,
    address: Address(streetAddress: "Pathé Joliette", city: "Marseillle", formattedAddress: "Pathé Joliette, Marseillle - 13000 Marseille", zipCode: "13002", lng: 46.0551, lat: 43.3123055)
)

#Preview {
    ActivityRow(activity: cinemaActivity)
}


/*/
 
 if let image = . {
     image
         .resizable()
         .scaledToFit()
         .frame(width: 60, height: 60)
         .cornerRadius(8)
 }
 */

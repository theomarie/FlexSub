import SwiftUI

struct ActivityView: View {
    var activity: Activity

    var body: some View {
        HStack {
            
            if let image = activity.etablissement.image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
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

              
                Text(activity.etablissement.name)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

               
                HStack {
                    Text("\(activity.etablissement.address.street), \(activity.etablissement.address.city) \(activity.etablissement.address.postalCode)")
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
    id: UUID(),
    username: "Stéphane",
    email: "stephane@example.com",
    password: "password123",
    address: "123 rue de Paris"
)

let cinemaActivity = Activity(
    title: "Terrifier 3",
    status: .published,
    owner: ownerUser,
    participant: nil,
    price: 10.50,
    date: Date(),
    category: .cinema,
    etablissement: etablissementPathe,
    location: "Cinéma Pathé, Paris",
    distance: 2.5
)

#Preview {
    ActivityView(activity: cinemaActivity)
}

import SwiftUI


struct TransactionDetailView: View {
    var partnerDisplayName: String
    var description: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Welcome to your detailed view!")
                    .font(.title2)
                    .padding(.bottom)
                Text("Here is your summary:")
                    .font(.title3)
                    .padding(.vertical)
                Text("This purchase was made at ") +
                Text("\(partnerDisplayName)")
                    .fontWeight(.bold) +
                Text("!")
                
                Text("The description of this product is: \(description)")
                    .font(.subheadline)
                    .padding(.vertical)
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("", displayMode: .inline)
    }
}


#Preview {
    TransactionDetailView(partnerDisplayName: "BP", description: "This is a Gas Station")
}

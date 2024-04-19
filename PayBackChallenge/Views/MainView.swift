import SwiftUI


struct MainView: View {
    @StateObject var viewModel = ViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.items) { item in
                VStack(alignment: .leading) {
                    Text(item.partnerDisplayName)
                    Text(item.transactionDetail.bookingDate)
                }
            }
            .navigationTitle("World of PayBack")
            .refreshable {
                viewModel.loadJson()
            }
        }
    }
}



#Preview {
    MainView()
}

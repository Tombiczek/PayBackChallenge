import SwiftUI


struct MainView: View {
    @StateObject var viewModel = ViewModel()

    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.items) { item in
                    VStack {
                        ZStack {
                            HStack {
                                HStack {
                                    VStack(alignment: .leading){
                                        Text(Helper.formatDate(item.transactionDetail.bookingDate))
                                            .font(.subheadline)
                                        Text(item.partnerDisplayName)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                        if ((item.transactionDetail.description?.isEmpty) != nil) {
                                            Text(item.transactionDetail.description ?? "")
                                                .font(.footnote)
                                        }
                                    }
                                }
                                Spacer()
                                Divider()
                                HStack {
                                    VStack {
                                        Text(String(item.transactionDetail.value.amount))
                                            .font(.title)
                                            .fontWeight(.bold)
                                        Text(item.transactionDetail.value.currency)
                                            .font(.subheadline)
                                    }
                                    .frame(minWidth: 80, maxWidth: 80, maxHeight: 70)
                                }
                                .padding(.horizontal, 5)
                            }
                            NavigationLink(destination: DetailView(), label: {EmptyView()}).opacity(0)
                        }
                    }
                }
                .listRowSpacing(10)
                .environment(\.defaultMinListRowHeight, 90)
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

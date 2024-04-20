import SwiftUI


struct TransactionListView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var showFilterOptions = false
    @State private var isLoading = false
    @State private var ifFailed = false
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    List(viewModel.filteredItems) { item in
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
                                            if (item.transactionDetail.description != nil) {
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
                                NavigationLink(destination: TransactionDetailView(
                                    partnerDisplayName: item.partnerDisplayName,
                                    description: item.transactionDetail.description ?? ""
                                ), label: {EmptyView()}).opacity(0)
                            }
                        }
                    }
                    .listRowSpacing(10)
                    .environment(\.defaultMinListRowHeight, 90)
                    .background(viewModel.filteredItems.isEmpty ? Text("No network") : nil)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showFilterOptions = true
                    } label: {
                        Label("Filter", systemImage: viewModel.activeFilter != nil ? "line.horizontal.3.decrease.circle.fill" : "line.horizontal.3.decrease.circle")
                    }
                }
            }
            .actionSheet(isPresented: $showFilterOptions) {
                ActionSheet(
                    title: Text("Filter Options"),
                    buttons: [
                        .default(Text("Category 1")) { viewModel.applyFilter(for: 1)},
                        .default(Text("Category 2")) { viewModel.applyFilter(for: 2)},
                        .default(Text("Reset Filter")) {viewModel.resetFilter()},
                        .cancel()
                    ]
                )
            }
            .navigationTitle("Transactions")
            .refreshable {
                await viewModel.loadJson()
            }
            .onAppear { // I know this is not a great solution
                Task {
                    isLoading = true
                    await viewModel.loadJson()
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    isLoading = false
                }
            }
        }
    }
}



#Preview {
    TransactionListView()
        .environmentObject(ViewModel())
}

import SwiftUI


struct TransactionListView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var showFilterOptions = false
    @State private var isLoading = false
    @State private var ifFailed = false
    @State private var sumTransactions = 0
    let network = NetworkStatus()
    
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                } else if !network.getNetworkState() {
                    GeometryReader { geometry in
                        ScrollView {
                            VStack {
                                Spacer()
                                NoNetworkView()
                                Spacer()
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        }
                    }
                } else if viewModel.filteredItems.isEmpty {
                    GeometryReader { geometry in
                        ScrollView {
                            VStack {
                                Spacer()
                                ErrorLoadingView()
                                Spacer()
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        }
                    }
                } else {
                    List {
                        VStack {
                            Text(viewModel.activeFilter == nil ? "All Transactions:" : "Category \(String(describing: viewModel.activeFilter!)) Transactions:")
                            Spacer()
                                .frame(height: 8)
                            HStack {
                                Spacer()
                                Text("\(viewModel.sumHelper()) PBP")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.blue)
                                Spacer()
                            } // HStack
                        } // VStack
                        ForEach(viewModel.filteredItems) { item in
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
                                            } // VStack
                                        } // HStack
                                        Spacer()
                                        Divider()
                                        HStack {
                                            VStack {
                                                Text(String(item.transactionDetail.value.amount))
                                                    .font(String(item.transactionDetail.value.amount).count > 4 ? .title2 : .title)
                                                    .fontWeight(.bold)
                                                Text(item.transactionDetail.value.currency)
                                                    .font(.subheadline)
                                            } // VStack
                                            .frame(width: 80, height: 80)
                                        } // HStack
                                        .padding(.horizontal, 5)
                                    } // HStack
                                    NavigationLink(destination: TransactionDetailView(
                                        partnerDisplayName: item.partnerDisplayName,
                                        description: item.transactionDetail.description ?? ""
                                    ), label: {EmptyView()}).opacity(0)
                                } // ZStack
                            } // VStack
                        } // ForEach
                    } // List
                    .listRowSpacing(10)
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
                        .default(Text("Category 1")) {
                            viewModel.applyFilter(for: 1)
                        },
                        .default(Text("Category 2")) {
                            viewModel.applyFilter(for: 2)
                        },
                        .default(Text("Category 3")) {
                            viewModel.applyFilter(for: 3)
                        },
                        .default(Text("Reset Filter")) {
                            viewModel.resetFilter()
                        },
                        .cancel()
                    ]
                )
            }
            .navigationTitle("Transactions")
            .refreshable {
                viewModel.loadJson()
                viewModel.applyFilter(for: viewModel.activeFilter)
            }
            .onAppear {
                Task {
                    isLoading = true
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
        .environment(\.defaultMinListRowHeight, 90)
}

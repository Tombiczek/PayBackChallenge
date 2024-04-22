import Foundation


class ViewModel: ObservableObject {
    @Published var items: [Items] = []
    @Published var filteredItems: [Items] = []
    @Published var activeFilter: Int? = nil
    
    
    init() {
        loadJson()
    }
    
    func loadJson() {
        items = loadJson(filename: "PBTransactions") ?? []
        filteredItems = items
    }
    
    private func loadJson(filename fileName: String) -> [Items]? {
        if Int.random(in: 1...10) == 5 {
            print("Error fetching data")
            return nil
        }
        
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let jsonData = try JSONDecoder().decode(Transactions.self, from: data)
                return jsonData.items.sorted(by: {
                           $0.transactionDetail.bookingDate > $1.transactionDetail.bookingDate
                       })
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
        return nil
    }
    
    func applyFilter(for category: Int?) {
        if category == nil {
            resetFilter()
        } else {
            activeFilter = category
            filteredItems = items.filter {$0.category == category}
        }
    }
    
    func resetFilter() {
        activeFilter = nil
        filteredItems = items
    }
    
    func sumHelper() -> Int {
        var sum = 0
        for item in filteredItems {
            sum += item.transactionDetail.value.amount
        }
        return sum
    }
}

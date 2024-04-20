import Foundation


class ViewModel: ObservableObject {
    @Published var items: [Item] = []
    @Published var filteredItems: [Item] = []
    @Published var activeFilter: Int? = nil
    
    
    init() {
        loadJson()
        filteredItems = items
    }
    
    func loadJson() {
        items = loadJson(filename: "PBTransactions") ?? []
    }
    
    private func loadJson(filename fileName: String) -> [Item]? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        func dateFromString(_ dateString: String) -> Date {
            return dateFormatter.date(from: dateString) ?? Date()
        }
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let items = try decoder.decode([String: [Item]].self, from: data)
                return items["items"]?.sorted(by: {
                           $0.transactionDetail.bookingDate > $1.transactionDetail.bookingDate
                       })
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
        return nil
    }
    
    func applyFilter(for category: Int) {
        activeFilter = category
        filteredItems = items.filter {$0.category == category}
    }
    
    func resetFilter() {
        activeFilter = nil
        filteredItems = items
    }
}

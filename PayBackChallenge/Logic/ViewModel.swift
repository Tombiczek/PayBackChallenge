import Foundation


class ViewModel: ObservableObject {
    @Published var items: [Item] = []
    
    
    init() {
        loadJson()
    }
    
    func loadJson() {
        items = loadJson(filename: "PBTransactions") ?? []
    }
    
    private func loadJson(filename fileName: String) -> [Item]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let items = try decoder.decode([String: [Item]].self, from: data)
                return items["items"]
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
        return nil
    }
}

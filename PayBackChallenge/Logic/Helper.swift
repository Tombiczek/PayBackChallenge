import Foundation


enum Helper {
    
    static func formatDate(_ dateIn: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = inputFormatter.date(from: dateIn) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateStyle = .long
            outputFormatter.timeStyle = .short
            return outputFormatter.string(from: date)
            
        } else {
            
            return "Invalid date"
        }
    }



    static func sortItems(items: [Item], for sortOption: SortOptions) -> [Item] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        func dateFromString(_ dateString: String) -> Date {
            return dateFormatter.date(from: dateString) ?? Date()
        }
        
        switch sortOption {
        case .dateAscending:
            return items.sorted { dateFromString($0.transactionDetail.bookingDate) < dateFromString($1.transactionDetail.bookingDate) }
        case .dateDescending:
            return items.sorted { dateFromString($0.transactionDetail.bookingDate) > dateFromString($1.transactionDetail.bookingDate) }
        case .none:
            return items
        }
    }
}







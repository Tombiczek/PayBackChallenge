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
}

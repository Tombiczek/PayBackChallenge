import Foundation


struct Item: Codable, Identifiable {
    var id: String {
        alias.reference
    }
    let partnerDisplayName: String
    let alias: Alias
    let category: Int
    let transactionDetail: TransactionDetail

    struct Alias: Codable {
        let reference: String
    }

    struct TransactionDetail: Codable {
        let description: String?
        let bookingDate: String
        let value: Value

        struct Value: Codable {
            let amount: Int
            let currency: String
        }
    }
}








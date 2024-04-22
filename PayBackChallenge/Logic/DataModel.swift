import Foundation



struct Transactions: Decodable {
    let items: [Items]
}

struct Items: Decodable, Identifiable {
    var id: String {
        alias.reference
    }
    
    let partnerDisplayName: String
    let alias: Alias
    let category: Int
    let transactionDetail: TransactionDetail

    struct Alias: Decodable {
        let reference: String
    }

    struct TransactionDetail: Decodable {
        let description: String?
        let bookingDate: String
        let value: Value

        struct Value: Decodable {
            let amount: Int
            let currency: String
        }
    }
}








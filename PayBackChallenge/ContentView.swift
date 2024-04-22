import SwiftUI

struct ContentView: View {
    var body: some View {
        TransactionListView()
    }
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
        .environment(\.defaultMinListRowHeight, 90)
}

import SwiftUI

struct NoNetworkView: View {
    var body: some View {
        VStack {
            Image(systemName: "wifi.exclamationmark")
                .font(.largeTitle)
                .foregroundColor(.red)
            Text("No Network Connection")
                .font(.headline)
                .padding()
            Text("Please check your internet connection and try again.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

struct ErrorLoadingView: View {
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.largeTitle)
                .foregroundColor(.yellow)
            Text("Some Error Has Occured")
                .font(.headline)
                .padding()
            Text("Please try to restart the application and try again.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}


#Preview {
    NoNetworkView()
}

#Preview {
    ErrorLoadingView()
}


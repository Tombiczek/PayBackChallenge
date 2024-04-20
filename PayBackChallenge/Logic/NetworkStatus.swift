import Network
import Combine

class NetworkStatus {
    
    private var connected = true
    
    static let shared = NetworkStatus()
    
    private let monitor = NWPathMonitor()
    
    
    init () {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    self?.connected = true
                } else {
                    self?.connected = false
                }
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    func getNetworkState() -> Bool {
        return connected
    }
}

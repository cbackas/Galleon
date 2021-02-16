// Created for Galleon in 2021
// Using Swift 5.0

import Foundation

final class QueueViewModel: ObservableObject {
    @Published var queue: [SonarrQueueEntry] = []
    @Published var lastQueued: Date = Date()
    
    public static let shared: QueueViewModel = {
        let instance = QueueViewModel()
        return instance
    }()
    
    init() {
        queueUpdateLoop()
    }
    
    // update the calendar every minute
    func queueUpdateLoop() -> Void {
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.updateData()
            self.queueUpdateLoop()
        }
    }
    
    func updateData() {
        SonarrComm.shared.getQueue() {
            queue, errorDescription in
            if (errorDescription != nil) {
                print("lol error: \(errorDescription!)")
            } else {
                self.queue = queue!

                self.lastQueued = Date()
            }
        }
    }
}

// Created for Galleon in 2021
// Using Swift 5.0

import Foundation
import SwiftUI

final class EpisodeViewModel: ObservableObject {
    @Published var episode: SonarrCalendarEntry? = nil
    @Published var episodeHistory: [SonarrHistoryRecord] = []
    @Published var historyLoading: Bool = false
    
    init() {
        updateHistory(true)
    }
    
//    public static let shared: EpisodeViewModel = {
//        let instance = EpisodeViewModel()
//        return instance
//    }()
    
    func updateHistory(_ useIndicator: Bool?) {
        self.historyLoading = false
        if (useIndicator != nil) {
            self.historyLoading = useIndicator!
        }
        if (episode != nil) {
            // try to update from API
            SonarrComm.shared.getHistory(episodeID: episode!.id!) {
                history, errorDescription in
                if (errorDescription != nil) {
                    print("lol error: \(errorDescription!)")
                } else {
                    // update items user can see
                    self.episodeHistory = history!.records!
                    
                    // make sure loading indicator isn't showing anymore
                    self.historyLoading = false
                }
            }
        }
    }
}

// Created for Galleon in 2021
// Using Swift 5.0

import Foundation

class SeriesViewModel: ObservableObject {
    @Published var seriesList: [SonarrSeries] = []
    @Published var lastUpdated: Date = Date()
    
    init() {
        updateData()
        self.seriesUpdateLoop()
    }
    
    // update the series data every 5 minutes
    func seriesUpdateLoop() -> Void {
        DispatchQueue.main.asyncAfter(deadline: .now() + (60*5)) {
            self.updateData()
            self.seriesUpdateLoop()
        }
    }
    
    func updateData() {
        SonarrComm.shared.getAllSeries() {
            allSeries, errorDescription in
            if (errorDescription != nil) {
                print("lol error: \(errorDescription!)")
            } else {
                let sorted = allSeries!.sorted {
                    lhs, rhs in
                    lhs.sortTitle! < rhs.sortTitle!
                }
                
                self.seriesList = sorted

                self.lastUpdated = Date()
            }
        }
    }
}

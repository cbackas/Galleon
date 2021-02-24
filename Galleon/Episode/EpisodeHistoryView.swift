// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct EpisodeHistory: View {
    var episode: SonarrCalendarEntry
    var episodeHistory: [SonarrHistoryRecord]
    
    var body: some View {
        if (episodeHistory.count == 0) {
            Text("No episode history.")
        } else {
            LazyVStack {
                ScrollView {
                    ForEach(episodeHistory, id: \.id) {
                        entry in
                        HistoryRecord(record: entry)
                            .padding(.horizontal, 40)
                    }
                }
            }
        }
    }
}

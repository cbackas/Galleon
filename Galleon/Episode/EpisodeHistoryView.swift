// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct EpisodeHistory: View {
    @ObservedObject var episodeViewModel: EpisodeViewModel = EpisodeViewModel.shared
    
    var body: some View {
        VStack {
//            HStack {
//                Spacer()
//                if (episodeViewModel.historyLoading) {
//                    ProgressView()
//                }
//                Spacer()
//            }
            ScrollView {
                ForEach(episodeViewModel.episodeHistory, id: \.id) {
                    entry in
                    HistoryRecord(record: entry)
                        .padding(.horizontal, 40)
                }
            }
            //            if (episodeViewModel.historyLoading) {
            //                ScrollView {
            //                    ForEach(episodeViewModel.episodeHistory, id: \.id) {
            //                        entry in
            //                        HistoryRecord(record: entry)
            //                            .padding(.horizontal, 40)
            //                    }
            //                }
            //            }
            //            ScrollView {
            //                ForEach(episodeViewModel.episodeHistory, id: \.id) {
            //                    entry in
            //                    HistoryRecord(record: entry)
            //                        .padding(.horizontal, 40)
            //                }
            //            }
            //            .zIndex(0)
        }
    }
}

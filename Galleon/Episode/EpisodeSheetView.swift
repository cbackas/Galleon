// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct EpisodeSheet: View {
    var episode: SonarrCalendarEntry
    
    @State var episodeHistory: [SonarrHistoryRecord] = []
    
    @State private var selection = "details"
    
    var body: some View {
        VStack {
            Text("\(episode.series!.title!) - \(episode.seasonNumber!)x\(episode.episodeNumber!) - \(episode.title!)")
                .font(.headline)
            
            TabView(selection: $selection) {
                EpisodeDetail(episode: episode)
                    .tabItem {
                        Text("Details")
                    }
                    .tag("details")
                EpisodeHistory(episode: episode, episodeHistory: episodeHistory)
                    .tabItem {
                        Text("History")
                    }
                    .tag("history")
                EpisodeSearch()
                    .tabItem {
                        Text("Search")
                    }
                    .tag("search")
            }
            .onChange(of: selection) { _ in
                if (selection == "history") {
                    SonarrComm.shared.getHistory(episodeID: episode.id!) {
                        history, errorDescription in
                        if (errorDescription != nil) {
                            print("lol error: \(errorDescription!)")
                        } else {
                            // update items user can see
                            episodeHistory = history!.records!
                        }
                    }
                }
            }
        }
    }
}

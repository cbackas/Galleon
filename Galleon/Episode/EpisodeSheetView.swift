// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct EpisodeSheet: View {
    var episode: SonarrCalendarEntry
    @ObservedObject var viewModel: ViewModel
    
    @State private var selection = "details"
    
    var body: some View {
        VStack {
            Text("\(episode.series!.title!) - \(episode.seasonNumber!)x\(episode.episodeNumber!) - \(episode.title!)")
                .font(.headline)
            
            TabView(selection: $selection) {
                EpisodeDetail(episode: episode, viewModel: viewModel)
                    .tabItem {
                        Text("Details")
                    }
                    .tag("details")
                EpisodeHistory()
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
        }
    }
}

// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct EpisodeSheet: View {
    var episode: SonarrCalendarEntry
    @ObservedObject var calendarViewModel: CalendarViewModel
    
    @ObservedObject var episodeViewModel: EpisodeViewModel = EpisodeViewModel.shared
    
    init(episode: SonarrCalendarEntry, calendarViewModel: CalendarViewModel) {
        self.episode = episode
        self.calendarViewModel = calendarViewModel
        
        episodeViewModel.episode = episode
    }
    
    @State private var selection = "details"
    
    var body: some View {
        VStack {
            Text("\(episode.series!.title!) - \(episode.seasonNumber!)x\(episode.episodeNumber!) - \(episode.title!)")
                .font(.headline)
            
            TabView(selection: $selection) {
                EpisodeDetail()
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
            .onChange(of: selection) { _ in
                if (selection == "history") {
                    episodeViewModel.updateHistory(false)
                }
            }
        }
    }
}

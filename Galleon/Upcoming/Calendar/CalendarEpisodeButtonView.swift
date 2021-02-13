// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct CalendarEpisodeButton: View {
    var episode: SonarrCalendarEntry
    @ObservedObject var calendarViewModel: CalendarViewModel
    
    @State var showEpisodeSheet: Bool = false
    
    var body: some View {
        Button(action: {
            showEpisodeSheet = true
        }) {
            CalendarEpisode(episode: episode, calendarViewModel: calendarViewModel)
                .sheet(isPresented: $showEpisodeSheet) {
                    EpisodeSheet(episode: episode, calendarViewModel: calendarViewModel)
                }
        }
        .padding(.horizontal, 40)
    }
}

// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct MonthEpisodeButtonView: View {
    var episode: SonarrCalendarEntry
    @ObservedObject var calendarViewModel: CalendarViewModel
    
    @State var showEpisodeSheet: Bool = false
    
    var body: some View {
        Button(action: {
            showEpisodeSheet = true
        }) {
            MonthEpisodeView(episode: episode, calendarViewModel: calendarViewModel)
                .sheet(isPresented: $showEpisodeSheet) {
                    EpisodeSheet(episode: episode)
                }
        }
        .padding(.horizontal, 40)
    }
}

// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct CalendarEpisodeViewButton: View {
    var episode: SonarrCalendarEntry
    @ObservedObject var calendarViewModel: CalendarViewModel
    
    @State var background = Color.clear
    @State var showEpisodeSheet: Bool = false
    
    var body: some View {
        Button(action: {
            showEpisodeSheet = true
        }) {
            CalendarEpisodeView(episode: episode, calendarViewModel: calendarViewModel)
                .padding(10)
                .sheet(isPresented: $showEpisodeSheet) {
                    EpisodeSheet(episode: episode)
                }
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.horizontal, 40)
    }
}

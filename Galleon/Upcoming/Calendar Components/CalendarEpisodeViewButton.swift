// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct CalendarEpisodeViewButton: View {
    var episode: SonarrCalendarEntry
    
    @State var background = Color.clear
    @State var showEpisodeSheet: Bool = false
    
    var body: some View {
        Button(action: {
            showEpisodeSheet = true
        }) {
            CalendarEpisodeView(episode: episode)
                .padding(10)
                .sheet(isPresented: $showEpisodeSheet) {
                    EpisodeSheet(episode: episode)
                }
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.horizontal, 40)
    }
}

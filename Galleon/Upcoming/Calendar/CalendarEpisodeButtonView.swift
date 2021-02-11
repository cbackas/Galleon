// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct CalendarEpisodeButton: View {
    var episode: SonarrCalendarEntry
    @ObservedObject var viewModel: ViewModel
    
    @State var showEpisodeSheet: Bool = false
    
    var body: some View {
        Button(action: {
            showEpisodeSheet = true
        }) {
            CalendarEpisode(episode: episode, viewModel: viewModel)
                .sheet(isPresented: $showEpisodeSheet) {
                    EpisodeSheet(episode: episode, viewModel: viewModel)
                }
        }
        .padding(.horizontal, 40)
    }
}

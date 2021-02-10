// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct CalendarDayModal: View {
    var episodeEntries: [SonarrCalendarEntry]
    @ObservedObject var viewModel: ViewModel
    
    @State private var showModal = false
    
    var body: some View {
        ForEach(episodeEntries, id: \.self) {
            episode in
            CalendarEpisode(episode: episode, viewModel: viewModel)
        }
    }
}

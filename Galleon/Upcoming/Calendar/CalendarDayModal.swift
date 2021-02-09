// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct CalendarDayModal: View {
//    @ObservedObject var viewModel: ViewModel
    
    var episodeEntries: [SonarrCalendarEntry]
    
    @State private var showModal = false
    
    var body: some View {
        ForEach(episodeEntries, id: \.self) {
            episode in
            CalendarEpisode(episode: episode)
        }
    }
}

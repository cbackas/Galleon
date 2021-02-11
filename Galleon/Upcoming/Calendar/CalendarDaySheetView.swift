// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct CalendarDaySheet: View {
    var date: Date
    var episodeEntries: [SonarrCalendarEntry]
    @ObservedObject var viewModel: ViewModel
    
    @State private var showModal = false
    
    var dateFormatter = DateFormatter()
    var dateHeading = ""
    
    init(date: Date, episodeEntries: [SonarrCalendarEntry], viewModel: ViewModel) {
        self.date = date
        self.episodeEntries = episodeEntries
        self.viewModel = viewModel
        
        dateFormatter.dateFormat = "EEEE, MMM d yyyy"
        dateHeading = dateFormatter.string(from: date)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(episodeEntries, id: \.self) {
                        episode in
                        CalendarEpisodeButton(episode: episode, viewModel: viewModel)
                    }
                    Spacer()
                }
            }
            .frame(width: 500)
            .navigationTitle(dateHeading)
        }
    }
}

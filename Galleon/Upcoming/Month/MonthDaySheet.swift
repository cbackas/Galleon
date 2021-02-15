// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct MonthDaySheet: View {
    var date: Date
    var episodeEntries: [SonarrCalendarEntry]
    @ObservedObject var calendarViewModel: CalendarViewModel
    
    @State private var showModal = false
    
    var dateFormatter = DateFormatter()
    var dateHeading = ""
    
    init(date: Date, episodeEntries: [SonarrCalendarEntry], calendarViewModel: CalendarViewModel) {
        self.date = date
        self.episodeEntries = episodeEntries
        self.calendarViewModel = calendarViewModel
        
        dateFormatter.dateFormat = "EEEE, MMM d yyyy"
        dateHeading = dateFormatter.string(from: date)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(episodeEntries, id: \.self) {
                        episode in
                        MonthEpisodeButtonView(episode: episode, calendarViewModel: calendarViewModel)
                    }
                    Spacer()
                }
            }
            .frame(width: 500)
            .navigationTitle(dateHeading)
        }
    }
}

// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct DayView: View {
    var date: Date?
    var episodeEntries: [SonarrCalendarEntry]?
    @ObservedObject var calendarViewModel: CalendarViewModel
    
    var dateFormatter = DateFormatter()
    var dateHeading = ""
    
    init(date: Date? = nil, episodeEntries: [SonarrCalendarEntry]? = nil, calendarViewModel: CalendarViewModel) {
        self.date = date
        self.episodeEntries = episodeEntries
        self.calendarViewModel = calendarViewModel
        
        if (date != nil) {
            dateFormatter.dateFormat = "EEEE, MMM d yyyy"
            dateHeading = dateFormatter.string(from: date!)
        }
    }
    
    var body: some View {
        ScrollView { // this scrollview improves scroll performance
            VStack(spacing: 10) {
                Text(dateHeading)
                    .font(.headline)
                    .preferredColorScheme(.dark)
                    .frame(alignment: .center)
                ForEach(episodeEntries ?? (calendarViewModel.visibleEntries.first?.episodeEntries ?? []), id: \.self) {
                    episode in
                    CalendarEpisodeViewButton(episode: episode, calendarViewModel: calendarViewModel)
                }
            }
            .frame(width: 1850)
            .padding(.horizontal, 40)
            .padding(.bottom, 80)
            .edgesIgnoringSafeArea(.horizontal)
            .edgesIgnoringSafeArea(.top)
            .navigationTitle(dateHeading)
        }
    }
}

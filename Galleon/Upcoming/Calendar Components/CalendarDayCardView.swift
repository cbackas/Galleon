// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct CalendarDayCardView: View {
    var calData: CalDayData
    @ObservedObject var calendarViewModel: CalendarViewModel
    var height: CGFloat?

    @State private var episodeSelectionMode = false
    
    var dateText = ""
    var isToday = false
    var isCurrentMonth = true
    
    var episodes: [SonarrCalendarEntry] = []
    
    init(calData: CalDayData, calendarViewModel: CalendarViewModel, height: CGFloat? = nil) {
        self.calData = calData
        self.calendarViewModel = calendarViewModel
        self.height = height
        
        // episode stuff
        episodes = calData.episodeEntries!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        dateText = dateFormatter.string(from: calData.date)
        
        let today = Date()
        isToday = Date.isSameDay(date1: calData.date, date2: today)
        isCurrentMonth = Date.isSameMonth(date1: calData.date, date2: today)
    }
    
    var body: some View {
        Button(action: {
            episodeSelectionMode = true
        }) {
            VStack {
                HStack {
                    Spacer()
                    Text("\(dateText)")
                        .font(.caption)
                        .padding(.trailing, 5)
                }
                .frame(height: 40)
                .background(isToday ? Color.blue : (isCurrentMonth ? Color(UIColor.lightGray) : Color(UIColor.darkGray)))
                
                ForEach(episodes, id: \.self) {
                    episode in
                    MonthEpisodeView(episode: episode, calendarViewModel: calendarViewModel)
                }
                
                Spacer()
            }
            .frame(width: 237, height: height ?? calData.height)
        }
        .sheet(isPresented: $episodeSelectionMode) {
            DayView(date: calData.date, episodeEntries: episodes, calendarViewModel: calendarViewModel)
        }
        .buttonStyle(CardButtonStyle())
        .animation(.easeInOut(duration: 0.25))
    }
}

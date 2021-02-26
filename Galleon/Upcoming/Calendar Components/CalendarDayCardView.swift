// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct CalendarDayCardView: View {
    var calData: CalDayData
    var height: CGFloat?

    @ObservedObject var calVM = CalendarViewModel.shared
    @State private var episodeSelectionMode = false
    
    var dateText = ""
    var isToday = false
    var isCurrentMonth = true
    
    var episodes: [SonarrCalendarEntry] = []
    
    init(calData: CalDayData, height: CGFloat? = nil) {
        self.calData = calData
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
                    CalendarEpisodeView(episode: episode)
                }
                
                Spacer()
            }
            .frame(width: 237, height: height ?? calData.height)
        }
        .sheet(isPresented: $episodeSelectionMode) {
            DayView(date: calData.date, episodeEntries: episodes)
        }
        .buttonStyle(CardButtonStyle())
        .animation(.easeInOut(duration: 0.25))
    }
}

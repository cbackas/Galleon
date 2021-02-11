// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct CalendarDay: View {
    @ObservedObject var viewModel: ViewModel
    
    @State private var episodeSelectionMode = false
    
    var calData: CalDayData
    var dateText = ""
    var isToday = false
    var isCurrentMonth = true
    
    var episodes: [SonarrCalendarEntry] = []
    var rowHeight: CGFloat = 250
    
    init(calData: CalDayData, viewModel: ViewModel) {
        self.calData = calData
        self.viewModel = viewModel
        
        // episode stuff
        episodes = calData.episodeEntries!
        // row height comes from ViewModel!!!
        rowHeight = viewModel.calendarRowHeights[calData.row] ?? 250
        
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
                .background(isToday ? Color.blue : (isCurrentMonth ? Color(UIColor.lightGray) : Color(UIColor.darkGray)))
                
                ForEach(episodes, id: \.self) {
                    episode in
                    CalendarEpisode(episode: episode, viewModel: viewModel)
                }
                
                Spacer()
            }
            .frame(width: 237, height: rowHeight)
        }
        .sheet(isPresented: $episodeSelectionMode) {
            CalendarDaySheet(date: calData.date, episodeEntries: episodes, viewModel: viewModel)
        }
        .buttonStyle(CardButtonStyle())
        .animation(.easeInOut(duration: 0.5))
    }
}

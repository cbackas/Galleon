// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct CalendarDay: View {
    @ObservedObject var viewModel: ViewModel
    
    @State private var showModal = false
    
    var dateText = ""
    var isToday = false
    var isCurrentMonth = true
    
    var episodes: [SonarrCalendarEntry] = []
    var rowHeight: CGFloat = 250
    
    init(calData: CalDayData, viewModel: ViewModel) {
        self.viewModel = viewModel
        // row height comes from ViewModel!!!
        rowHeight = viewModel.calendarRowHeights[calData.row] ?? 250
        // date stuff
        let date = calData.date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        dateText = dateFormatter.string(from: date)
        
        let today = Date()
        isToday = Date.isSameDay(date1: date, date2: today)
        isCurrentMonth = Date.isSameMonth(date1: date, date2: today)
        
        // episode stuff
        episodes = calData.episodeEntries!
    }
    
    var body: some View {
        Button(action: {
            self.showModal = true
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
                    CalendarEpisode(episode: episode)
                }
                Spacer()
            }
            .frame(width: 237, height: rowHeight)
        }
        .sheet(isPresented: $showModal, onDismiss: {
            print(self.showModal)
        }) {
            CalendarDayModal(episodeEntries: episodes)
        }
        .buttonStyle(CardButtonStyle())
        .animation(.easeInOut(duration: 10))
    }
}

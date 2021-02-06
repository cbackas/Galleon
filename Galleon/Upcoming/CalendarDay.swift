// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct CalendarDay: View {
    @ObservedObject var viewModel: ViewModel
//    @State var date: Date
    
    var dateText = ""
    var isToday = false
    var isCurrentMonth = true
    var episodeTitles: [String] = []
    
    var episodes: [SonarrCalendarEntry] = []
    var rowHeight: CGFloat
    
    init(calData: CalDayData, viewModel: ViewModel) {
        self.viewModel = viewModel
        // row height comes from ViewModel!!!
        rowHeight = viewModel.calendarRowHeights[calData.calendarRow] ?? 250
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
//        rowHeight = calData.rowHeight
    }
    
    var body: some View {
        Button(action: {
            print("Did a thing")
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
                    HStack {
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .fill(Color.yellow)
                            .frame(width: 4, height: 60)
                        VStack {
                            HStack {
                                Text((episode.series?.title)!)
                                    .lineLimit(1)
                                    .font(.system(size: 20))
                                Spacer()
                                Text("\(episode.seasonNumber!)x\(episode.episodeNumber!)")
                                    .font(.system(size: 15))
                            }
                            HStack {
                                Text(episode.title!)
                                    .lineLimit(1)
                                    .font(.system(size: 15))
                                Spacer()
                            }
                            HStack {
                                Text("time-time")
                                    .font(.system(size: 15))
                                Spacer()
                            }
                        }
                        .padding(.leading, -55)
                    }
                    .padding(.horizontal, 8)
                }
                Spacer()
            }
            .frame(width: 237, height: rowHeight)
        }
        .buttonStyle(CardButtonStyle())
    }
}

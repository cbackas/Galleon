// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct ForecastView: View {
    @ObservedObject var calendarViewModel: CalendarViewModel
    
    @State var rowHeight: CGFloat = 250
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    let weekdays = ["Yesterday", "Today", "Tomorrow", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    var body: some View {
        ScrollView { // this scrollview improves scroll performance
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(weekdays, id: \.self) { item in
                    Text(item)
                }
            }
            .padding(.horizontal, 40)
            
            Divider()
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(calendarViewModel.visibleEntries, id: \.hashValue) {
                    item in
                    CalendarDayCardView(calData: item, calendarViewModel: calendarViewModel, height: rowHeight)
                }
            }
            .frame(width: 1850)
            .padding(.horizontal, 40)
            .padding(.bottom, 80)
            .edgesIgnoringSafeArea(.horizontal)
            .edgesIgnoringSafeArea(.top)
            .onAppear() {
                rowHeight = calendarViewModel.visibleEntries.map { $0.height }.max() ?? rowHeight
            }
            .onChange(of: calendarViewModel.lastCalendarUpdate) {_ in
                rowHeight = calendarViewModel.visibleEntries.map { $0.height }.max()!
            }
        }
    }
}

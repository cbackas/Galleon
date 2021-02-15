// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI
import Foundation

struct MonthView: View {
    @ObservedObject var calendarViewModel: CalendarViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    let weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
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
                    CalendarDayCardView(calData: item, calendarViewModel: calendarViewModel)
                }
            }
            .frame(width: 1850)
            .padding(.horizontal, 40)
            .padding(.bottom, 80)
            .edgesIgnoringSafeArea(.horizontal)
            .edgesIgnoringSafeArea(.top)
        }
    }
    
}

// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct CalendarView: View {
    @ObservedObject var viewModel: ViewModel
    
    let weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(weekdays, id: \.self) { item in
                Text(item)
            }
        }
        .padding(.horizontal, 40)
        
        Divider()
        
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(viewModel.calendarEntries, id: \.self) { item in
                CalendarDay(calData: item, viewModel: viewModel)
            }
        }
        .frame(width: 1850)
        .padding(.horizontal, 40)
        .edgesIgnoringSafeArea(.horizontal)
        .edgesIgnoringSafeArea(.top)
    }
}

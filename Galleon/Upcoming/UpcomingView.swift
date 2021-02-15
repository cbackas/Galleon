// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct UpcomingView: View {
    @ObservedObject var calendarViewModel: CalendarViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    UpcomingPaginator(calendarViewModel: calendarViewModel)
                    
                    Button(action: {}) {
                        Text(calendarViewModel.calendarHeading)
                            .frame(maxWidth: .infinity)
                    }
                    
                    Button(action: {
                        // cycle through the views
                        switch (calendarViewModel.selectedView) {
                        case "month":
                            calendarViewModel.selectedView = "week"
                            calendarViewModel.updateWeek()
                        case "week":
                            calendarViewModel.selectedView = "forecast"
                        case "forecast":
                            calendarViewModel.selectedView = "day"
                        case "day":
                            calendarViewModel.selectedView = "agenda"
                        case "agenda":
                            calendarViewModel.selectedView = "month"
                            calendarViewModel.updateMonth()
                        default:
                            calendarViewModel.selectedView = "month"
                            calendarViewModel.updateMonth()
                        }
                        
                        StorageManager.instance.saveUpcomingViewSelection(viewSelection: calendarViewModel.selectedView)
                        calendarViewModel.calendarSelectedDate = calendarViewModel.getSelectedViewDate(view: calendarViewModel.selectedView)
                    }) {
                        Text(calendarViewModel.selectedView.capitalized)
                            .frame(width: 115)
                    }
                }
                .padding(.horizontal, 60)
                
                switch (calendarViewModel.selectedView) {
                case "month":
                    MonthView(calendarViewModel: calendarViewModel)
                case "week":
                    WeekView(calendarViewModel: calendarViewModel)
                case "forecast":
                    ForecastView(calendarViewModel: calendarViewModel)
                case "day":
                    DayView()
                case "agenda":
                    AgendaView()
                default:
                    MonthView(calendarViewModel: calendarViewModel)
                }
            }
        } // scrollview
    }
}

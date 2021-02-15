// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct UpcomingView: View {
    @ObservedObject var calendarViewModel: CalendarViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    CalendarPaginator(calendarViewModel: calendarViewModel)
                    
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
                            calendarViewModel.updateForecast()
                        case "forecast":
                            calendarViewModel.selectedView = "day"
                            calendarViewModel.updateDay()
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
                        .onAppear() {
                            calendarViewModel.updateData()
                        }
                case "week":
                    WeekView(calendarViewModel: calendarViewModel)
                        .onAppear() {
                            calendarViewModel.updateData()
                        }
                case "forecast":
                    ForecastView(calendarViewModel: calendarViewModel)
                        .onAppear() {
                            calendarViewModel.updateData()
                        }
                case "day":
                    DayView(calendarViewModel: calendarViewModel)
                        .onAppear() {
                            calendarViewModel.updateData()
                        }
                case "agenda":
                    AgendaView()
                        .onAppear() {
                            calendarViewModel.updateData()
                        }
                default:
                    MonthView(calendarViewModel: calendarViewModel)
                        .onAppear() {
                            calendarViewModel.updateData()
                        }
                }
            }
        } // scrollview
    }
}

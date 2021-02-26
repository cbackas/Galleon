// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct UpcomingView: View {
    @ObservedObject var calVM = CalendarViewModel.shared
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    CalendarPaginator()
                    
                    // wide button to make swiping up easier
                    Button(action: {}) {
                        Text(calVM.calendarHeading)
                            .frame(maxWidth: .infinity)
                    }
                    
                    // button to cycle between calendar views
                    Button(action: calendarTypeButtonAction) {
                        Text(calVM.selectedView.capitalized)
                            .frame(width: 115)
                    }
                }
                .padding(.horizontal, 60)
                
                SelecatedCalendarView
                    .onAppear() {
                        calVM.updateData()
                    }
                
                CalendarLegend()
                    .shadow(radius: 5)
                
            }
        } // scrollview
    }
    
    @ViewBuilder var SelecatedCalendarView: some View {
            switch (calVM.selectedView) {
            case "month":
                MonthView()
            case "week":
                WeekView()
            case "forecast":
                ForecastView()
            case "day":
                DayView()
            case "agenda":
                AgendaView()
            default:
                MonthView()
            }
    }
    
    func calendarTypeButtonAction() {
        // cycle through the views
        switch (calVM.selectedView) {
        case "month":
            calVM.selectedView = "week"
            calVM.updateWeek()
        case "week":
            calVM.selectedView = "forecast"
            calVM.updateForecast()
        case "forecast":
            calVM.selectedView = "day"
            calVM.updateDay()
        case "day":
            calVM.selectedView = "agenda"
        case "agenda":
            calVM.selectedView = "month"
            calVM.updateMonth()
        default:
            calVM.selectedView = "month"
            calVM.updateMonth()
        }
        
        // save change to view/storage
        StorageManager.instance.saveUpcomingViewSelection(viewSelection: calVM.selectedView)
        calVM.calendarSelectedDate = calVM.getSelectedViewDate(view: calVM.selectedView)
    }
}

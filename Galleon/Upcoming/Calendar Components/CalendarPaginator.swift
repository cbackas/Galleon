// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct CalendarPaginator: View {
    @ObservedObject var calendarViewModel: CalendarViewModel
    
    var body: some View {
        Button(action: {
            print("Back")
            pageBack(-1)
        }) {
            Image(systemName: "chevron.backward.2")
        }
        .buttonStyle(PlainButtonStyle())
        Button(action: {
            print("Today")
            pageBack(nil)
        }) {
            Text("Today")
        }
        .buttonStyle(DefaultButtonStyle())
        .padding(.horizontal, -20)
        Button(action: {
            pageBack(1)
        }) {
            Image(systemName: "chevron.forward.2")
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    func pageBack(_ amount: Int?) {
        switch (calendarViewModel.selectedView) {
        case "month":
            if (amount == nil) {
                calendarViewModel.calendarSelectedDate = Date().startOfMonth!
            } else {
                calendarViewModel.calendarSelectedDate = Calendar.current.date(byAdding: .month, value: amount!, to: calendarViewModel.calendarSelectedDate)!
            }
        case "week":
            if (amount == nil) {
                calendarViewModel.calendarSelectedDate = Date().startOfWeek!
            } else {
                calendarViewModel.calendarSelectedDate = Calendar.current.date(byAdding: .day, value: amount! * 7, to: calendarViewModel.calendarSelectedDate)!
            }
        case "forecast":
            if (amount == nil) {
                calendarViewModel.calendarSelectedDate = Date().resetTime!
            } else {
                calendarViewModel.calendarSelectedDate = Calendar.current.date(byAdding: .day, value: amount! * 7, to: calendarViewModel.calendarSelectedDate)!
            }
        case "day":
            if (amount == nil) {
                calendarViewModel.calendarSelectedDate = Date().resetTime!
            } else {
                calendarViewModel.calendarSelectedDate = Calendar.current.date(byAdding: .day, value: amount!, to: calendarViewModel.calendarSelectedDate)!
            }
        case "agenda":
            if (amount == nil) {
                calendarViewModel.calendarSelectedDate = Date().resetTime!
            } else {
                calendarViewModel.calendarSelectedDate = Calendar.current.date(byAdding: .day, value: amount! * 7, to: calendarViewModel.calendarSelectedDate)!
            }
        default:
            break
        }
        
        calendarViewModel.updateData()
    }
}


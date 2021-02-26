// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

/// Used to translate selected calendar date forward and backwards for displaying calendar data
struct CalendarPaginator: View {
    @ObservedObject var calVM = CalendarViewModel.shared
    
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
        switch (calVM.selectedView) {
        case "month":
            if (amount == nil) {
                calVM.calendarSelectedDate = Date().startOfMonth!
            } else {
                calVM.calendarSelectedDate = Calendar.current.date(byAdding: .month, value: amount!, to: calVM.calendarSelectedDate)!
            }
        case "week":
            if (amount == nil) {
                calVM.calendarSelectedDate = Date().startOfWeek!
            } else {
                calVM.calendarSelectedDate = Calendar.current.date(byAdding: .day, value: amount! * 7, to: calVM.calendarSelectedDate)!
            }
        case "forecast":
            if (amount == nil) {
                calVM.calendarSelectedDate = Date().resetTime!
            } else {
                calVM.calendarSelectedDate = Calendar.current.date(byAdding: .day, value: amount! * 7, to: calVM.calendarSelectedDate)!
            }
        case "day":
            if (amount == nil) {
                calVM.calendarSelectedDate = Date().resetTime!
            } else {
                calVM.calendarSelectedDate = Calendar.current.date(byAdding: .day, value: amount!, to: calVM.calendarSelectedDate)!
            }
        case "agenda":
            if (amount == nil) {
                calVM.calendarSelectedDate = Date().resetTime!
            } else {
                calVM.calendarSelectedDate = Calendar.current.date(byAdding: .day, value: amount! * 7, to: calVM.calendarSelectedDate)!
            }
        default:
            break
        }
        
        calVM.updateData()
    }
}


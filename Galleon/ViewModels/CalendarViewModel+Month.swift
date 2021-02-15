// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

extension CalendarViewModel {
    func updateMonth() {
        let date = self.calendarSelectedDate
        
        let startOfMonth = date.startOfMonth!
        let endOfMonth = date.endOfMonth!
        let hangingStart = startOfMonth.startOfWeek!
        let hangingEnd = endOfMonth.endOfWeek!
        
        self.updateData(startDate: hangingStart, endDate: hangingEnd) {
            calDayData in
            
            // if the data we just recieved is for the page thats still selected
            if (self.selectedView == "month" && self.calendarSelectedDate == startOfMonth) {
                // update view
                self.visibleEntries = calDayData
            }
            
            self.lastCalendarUpdate = Date()
        }
    }
}

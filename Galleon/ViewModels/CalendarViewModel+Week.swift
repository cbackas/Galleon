// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

extension CalendarViewModel {
    func updateWeek() {
        let date = self.calendarSelectedDate
        
        let startOfWeek = date.startOfWeek!
        let endOfWeek = date.endOfWeek!
        
        self.updateData(startDate: startOfWeek, endDate: endOfWeek) {
            calDayData in
            
            // if the data we just recieved is for the page thats still selected
            if (self.selectedView == "week" && self.calendarSelectedDate == startOfWeek) {
                // update view
                self.visibleEntries = calDayData
            }
            
            self.lastCalendarUpdate = Date()
        }
    }
}

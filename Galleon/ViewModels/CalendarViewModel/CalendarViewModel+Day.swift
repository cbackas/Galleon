// Created for Galleon in 2021
// Using Swift 5.0

import Foundation

extension CalendarViewModel {
    func updateDay() {
        let date = self.calendarSelectedDate
        
        self.updateData(startDate: date, endDate: date) {
            calDayData in
            
            // if the data we just recieved is for the page thats still selected
            let filteredData = calDayData.filter { $0.date == self.calendarSelectedDate }
            if (filteredData.count > 0) {
                self.visibleEntries = filteredData
            }
            
            self.lastCalendarUpdate = Date()
        }
    }
}

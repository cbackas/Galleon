// Created for Galleon in 2021
// Using Swift 5.0

import Foundation

extension CalendarViewModel {
    func updateForecast() {
        let date = self.calendarSelectedDate
        
        let startOfForecast = Calendar.current.date(byAdding: .day, value: -1, to: date)!
        let endOfForecast = Calendar.current.date(byAdding: .day, value: 5, to: date)!
        
        self.updateData(startDate: startOfForecast, endDate: endOfForecast) {
            calDayData in
            
            // if the data we just recieved is for the page thats still selected
            if (self.selectedView == "forecast" && self.calendarSelectedDate == date) {
                // update view
                self.visibleEntries = calDayData
            }
            
            self.lastCalendarUpdate = Date()
        }
    }
}

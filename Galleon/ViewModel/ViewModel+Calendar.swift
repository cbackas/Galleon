// Created for Galleon in 2021
// Using Swift 5.0

import Foundation
import SwiftUI

extension ViewModel {
    func updateCalendarMonthHeading() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL yyyy"
        self.calendarHeading = dateFormatter.string(from: self.calendarMonth)
    }
    
    func updateCalendar() {
        let date = self.calendarMonth
        
        self.updateCalendarMonthHeading()
        
        let cachedData = self.calendarMonthCache[date] ?? self.calendarEntries
        self.calendarEntries = cachedData
        self.calendarRowHeights = self.calendarMonthRowHeightsCache[date] ?? self.calendarRowHeights
        
        let startOfMonth = date.startOfMonth!
        let endOfMonth = date.endOfMonth!
        let hangingStart = startOfMonth.startOfWeek!
        let hangingEnd = endOfMonth.endOfWeek!
        SonarrComm.shared.getCalendar(startDate: hangingStart, endDate: hangingEnd) {
            calendar, errorDescription in
            if (errorDescription != nil) {
                print("lol error: \(errorDescription!)")
            } else {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                
                let timeFormatter = DateFormatter()
                timeFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
                timeFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                
                // list of all the dates shown on the calendar
                let allDates = Date.datesInRange(from: hangingStart, to: hangingEnd)
                
                var calendarData = calendar!
                var calDayData: [CalDayData] = []
                var newRowHeights = [Int:CGFloat]()
                
                // for every day on the cal go through and build out the episodes
                for (index, calDate) in allDates.enumerated() {
                    let formattedDate = formatter.string(from: calDate)
                    let matchingEntries = calendarData.filter {
                        // convert string UTC airDate to Date()
                        let dateAirDateUTC = timeFormatter.date(from: $0.airDateUTC!)
                        // convert UTC Date() to String in localTZ
                        let stringAirDateLocal = formatter.string(from: dateAirDateUTC!)
                        
                        return stringAirDateLocal == formattedDate
                    }
                    
                    // if there aren't any matching entries, no need to to try to remove entries for that day
                    if (!matchingEntries.isEmpty)  {
                        calendarData.removeAll {
                            // convert string UTC airDate to Date()
                            let dateAirDateUTC = timeFormatter.date(from: $0.airDateUTC!)
                            // convert UTC Date() to String in localTZ
                            let stringAirDateLocal = formatter.string(from: dateAirDateUTC!)
                            
                            return stringAirDateLocal == formattedDate
                        }
                    }
                    
                    // calculate the height needed to show these entries and save them on a rowly basis so each row can be the same height
                    let row = (index / 7) + 1
                    let oldRowHeight = newRowHeights[row] ?? CGFloat(250)
                    let newRowHeight = CGFloat(40 + (matchingEntries.count * 75))
                    if (oldRowHeight < newRowHeight) {
                        newRowHeights[row] = newRowHeight
                    }
                    let newCalDayData = CalDayData(date: calDate, episodeEntries: matchingEntries, row: row)
                    calDayData.append(newCalDayData)
                }
                // if the data we just recieved is for the page thats still selected
                if (date == self.calendarMonth) {
                // update view
                    self.calendarEntries = calDayData
                    self.calendarRowHeights = newRowHeights
                }
                self.lastCalendarUpdate = Date()
                // always cache the data whether we're showing it still or not
                // update cache
                self.calendarMonthCache[date] = calDayData
                self.calendarMonthRowHeightsCache[date] = newRowHeights
            }
        }
    }
}

// Created for Galleon in 2021
// Using Swift 5.0

import Foundation
import SwiftUI

final class ViewModel: ObservableObject {
    @Published var calendarEntries: [CalDayData] = []
    @Published var calendarRowHeights = [Int:CGFloat]() // rowHeights calculated in getMonthlyEntries
    
    init() {
        self.getMonthlyEntries()
    }
    
    func getMonthlyEntries() {
        let date = Date()
        
        let startOfMonth = date.startOfMonth!
        let endOfMonth = date.endOfMonth!
        let hangingStart = startOfMonth.startOfWeek!
        let hangingEnd = endOfMonth.endOfWeek!
        
        SonarrComm.shared.getCalendarEntries(startDate: hangingStart, endDate: hangingEnd) {
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
                    let oldRowHeight = self.calendarRowHeights[row] ?? CGFloat(250)
                    let newRowHeight = CGFloat(40 + (matchingEntries.count * 75))
                    if (oldRowHeight < newRowHeight) {
                        self.calendarRowHeights[row] = newRowHeight
                    }
                    
                    let newCalDayData = CalDayData(date: calDate, episodeEntries: matchingEntries, calendarRow: row)
                    calDayData.append(newCalDayData)
                }
                self.calendarEntries = calDayData
            }
        }
    }
    
    //    func updateBoards(closure: @escaping ((_ loaded: Bool) -> Void)) {
    //        Nextcloud.shared.getBoards() {
    //            (boards) in
    //            self.boards = boards
    //            DataManager().setBoards(boards)
    //            closure(true)
    //        }
    //    }
    //
    //    func updateStacks(boardID: Int, closure: @escaping ((_ loaded: Bool) -> Void)) {
    //        Nextcloud.shared.getStacks(boardID: boardID) {
    //            (stacks) in
    //            self.stackModel!.stacks = stacks
    //            DataManager().setStacks(stacks)
    //            closure(true)
    //        }
    //    }
}

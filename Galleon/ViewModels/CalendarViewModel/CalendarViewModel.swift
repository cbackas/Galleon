// Created for Galleon in 2021
// Using Swift 5.0

import Foundation
import SwiftUI

final class CalendarViewModel: ObservableObject {
    // calendar view
    @Published var visibleEntries: [CalDayData] = []
    @Published var selectedView: String
    @Published var calendarSelectedDate: Date = Date()
    @Published var calendarHeading: String = ""
    @Published var calendarCache: [CalDayData] = []
    @Published var lastCalendarUpdate: Date = Date()
    
    init() {
        selectedView = StorageManager.instance.getUpcomingViewSelection()
        calendarSelectedDate = getSelectedViewDate(view: selectedView)

        self.calendarUpdateLoop()
    }
    
    public static let shared: CalendarViewModel = {
        let instance = CalendarViewModel()
        return instance
    }()
    
    func getSelectedViewDate(view: String) -> Date {
        switch view {
        case "month":
            return Date().startOfMonth!
        case "week":
            return Date().startOfWeek!
        case "forecast":
            return Date().resetTime!
        case "day":
            return Date().resetTime!
        case "agenda":
            return Date().resetTime!
        default:
            return Date().startOfMonth!
        }
    }
    
    // update the calendar every minute
    func calendarUpdateLoop() -> Void {
        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            self.updateData()
            self.calendarUpdateLoop()
        }
    }
    
    func cachedDataToView(dates: [Date]) {
        var cachedDays = calendarCache.filter {
            dates.contains($0.date)
        }
        // if theres no cached info generate some blank days for them
        if (cachedDays.count == 0) {
            cachedDays = dates.enumerated().map {
                (index, day) in
                return CalDayData(date: day, episodeEntries: [], row: 1, height: 250)
            }
        }
        visibleEntries = cachedDays
    }
    
    func updateUpcomingHeading() {
        let dateFormatter = DateFormatter()
        
        switch self.selectedView {
        case "month":
            dateFormatter.dateFormat = "LLLL yyyy"
            self.calendarHeading = dateFormatter.string(from: self.calendarSelectedDate)
        case "week":
            self.calendarHeading = getWeekHeading()
        case "forecast":
            self.calendarHeading = getWeekHeading()
        case "day":
            dateFormatter.dateFormat = "EEEE, MMM d yyyy"
            self.calendarHeading = dateFormatter.string(from: self.calendarSelectedDate)
        case "agenda":
            self.calendarHeading = "Agenda"
        default:
            self.calendarHeading = ""
        }
    }
    
    func getWeekHeading() -> String {
        let firstDay = self.visibleEntries.first
        let lastDay = self.visibleEntries.last
        let firstDayComponents = Calendar.current.dateComponents([.day, .month, .year], from: firstDay!.date)
        let lastDayComponents = Calendar.current.dateComponents([.day, .month, .year], from: lastDay!.date)
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMM"
        
        var heading = "\(monthFormatter.string(from: firstDay!.date)) \(firstDayComponents.day!) - "
        heading.append(lastDayComponents.month != firstDayComponents.month ? monthFormatter.string(from: lastDay!.date) + " " : "")
        heading.append("\(lastDayComponents.day!) \(lastDayComponents.year!)")
        
        return heading
    }
    
    func updateData() -> Void {
        switch self.selectedView {
        case "month":
            self.updateMonth()
        case "week":
            self.updateWeek()
        case "forecast":
            self.updateForecast()
        case "day":
            self.updateDay()
        case "agenda":
            break
        default:
            break
        }
    }
    
    func updateData(startDate: Date, endDate: Date, completion: @escaping (_ calDayData: [CalDayData]) -> Void) {
        var apiStartDate = startDate
        var apiEndDate = endDate
        
        if (startDate == endDate) {
            apiStartDate = startDate.startOfWeek!
            apiEndDate = startDate.endOfWeek!
            
            self.cachedDataToView(dates: [startDate])
        }
        
        // list of all the dates shown on the calendar
        let allDates = Date.datesInRange(from: apiStartDate, to: apiEndDate)
        
        if (startDate != endDate) {
            self.cachedDataToView(dates: allDates)
        }
        
        self.updateUpcomingHeading()
        
        SonarrComm.shared.getCalendar(startDate: apiStartDate, endDate: apiEndDate) {
            calendar, errorDescription in
            if (errorDescription != nil) {
                print("lol error: \(errorDescription!)")
            } else {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                
                let timeFormatter = DateFormatter()
                timeFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
                timeFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                
                var calendarData = calendar!
                var calDayData: [CalDayData] = []
                var rowHeights = [Int:CGFloat]()
                
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
                    let oldRowHeight = rowHeights[row] ?? CGFloat(250)
                    let newRowHeight = CGFloat(40 + (matchingEntries.count * 75))
                    if (oldRowHeight < newRowHeight) {
                        rowHeights[row] = newRowHeight
                    }
                    let newCalDayData = CalDayData(date: calDate, episodeEntries: matchingEntries, row: row, height: 250)
                    
                    calDayData.append(newCalDayData)
                }
                
                // add height as a value of the data and cache it
                for index in 0..<calDayData.count {
                    calDayData[index].height = rowHeights[calDayData[index].row] ?? 250
                    self.calendarCache.removeAll() {
                        $0.date == calDayData[index].date
                    }
                    self.calendarCache.append(calDayData[index])
                }
                
                completion(calDayData)
            }
        }
    }
}

//    func initSelectedView() -> [CalDayData] {
//        let today = Date()
//
//        switch selectedView {
//        case "month":
//            let hangingStart = today.startOfMonth!.startOfWeek!
//            let hangingEnd = today.endOfMonth!.endOfWeek!
//            let allDates = Date.datesInRange(from: hangingStart, to: hangingEnd)
//            return allDates.enumerated().map {
//                (index, day) in
//                return CalDayData(date: day, episodeEntries: [], row: (index / 7) + 1, height: 250)
//            }
//        case "week":
//            let startOfWeek = today.startOfWeek!
//            let endOfWeek = today.endOfWeek!
//            let allDates = Date.datesInRange(from: startOfWeek, to: endOfWeek)
//            return allDates.enumerated().map {
//                (index, day) in
//                return CalDayData(date: day, episodeEntries: [], row: 1, height: 250)
//            }
//        case "forecast":
//            initForecast()
//        case "day":
//            initDay()
//        case "agenda":
//            initAgenda()
//        default:
//            break
//        }
//    }
//
//    func initForecast() {
//        //        let date = Date()
//        //        let startOfMonth = date.startOfMonth!
//        //        let endOfMonth = date.endOfMonth!
//        //        let hangingStart = startOfMonth.startOfWeek!
//        //        let hangingEnd = endOfMonth.endOfWeek!
//        //        let allDates = Date.datesInRange(from: hangingStart, to: hangingEnd)
//        //        self.visibleEntries = allDates.enumerated().map {
//        //            (index, day) in
//        //            return CalDayData(date: day, episodeEntries: [], row: (index / 7) + 1)
//        //        }
//    }
//
//    func initDay() {
//        //        let date = Date()
//        //        let startOfMonth = date.startOfMonth!
//        //        let endOfMonth = date.endOfMonth!
//        //        let hangingStart = startOfMonth.startOfWeek!
//        //        let hangingEnd = endOfMonth.endOfWeek!
//        //        let allDates = Date.datesInRange(from: hangingStart, to: hangingEnd)
//        //        self.visibleEntries = allDates.enumerated().map {
//        //            (index, day) in
//        //            return CalDayData(date: day, episodeEntries: [], row: (index / 7) + 1)
//        //        }
//    }
//
//    func initAgenda() {
//        //        let date = Date()
//        //        let startOfMonth = date.startOfMonth!
//        //        let endOfMonth = date.endOfMonth!
//        //        let hangingStart = startOfMonth.startOfWeek!
//        //        let hangingEnd = endOfMonth.endOfWeek!
//        //        let allDates = Date.datesInRange(from: hangingStart, to: hangingEnd)
//        //        self.visibleEntries = allDates.enumerated().map {
//        //            (index, day) in
//        //            return CalDayData(date: day, episodeEntries: [], row: (index / 7) + 1)
//        //        }
//    }

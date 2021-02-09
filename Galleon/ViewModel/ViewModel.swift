// Created for Galleon in 2021
// Using Swift 5.0

import Foundation
import SwiftUI

final class ViewModel: ObservableObject {
    // calendar view
    @Published var calendarEntries: [CalDayData] = []
    @Published var calendarMonth: Date = Date()
    @Published var calendarHeading: String = ""
    @Published var calendarRowHeights = [Int:CGFloat]()
    @Published var calendarMonthCache = [Date: [CalDayData]]()
    @Published var calendarMonthRowHeightsCache = [Date: [Int:CGFloat]]()
    // history view
    @Published var historyData: [SonarrHistory] = []
    @Published var visibleHistory: SonarrHistory? = nil
    @Published var selectedHistoryPage: Int = 1
    @Published var totalHistoryPages: Int = 1
    @Published var historyLoaded: Bool = false
    
    init() {
        let date = Date()
        let startOfMonth = date.startOfMonth!
        let endOfMonth = date.endOfMonth!
        let hangingStart = startOfMonth.startOfWeek!
        let hangingEnd = endOfMonth.endOfWeek!
        let allDates = Date.datesInRange(from: hangingStart, to: hangingEnd)
        self.calendarEntries = allDates.enumerated().map {
            (index, day) in
            return CalDayData(id: .init(), date: day, episodeEntries: [], row: (index / 7) + 1)
        }
        
        self.historyData = []
        
        self.calendarUpdateLoop()
        self.historyUpdateLoop()
    }
    
    // update the calendar every minute
    func calendarUpdateLoop() -> Void {
//        print("[Keep Alive] Calendar updater")
        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            self.updateCalendar()
            self.calendarUpdateLoop()
        }
    }
    
    // update the history data every 2 minutes
    func historyUpdateLoop() -> Void {
//        print("[Keep Alive] History updater")
        DispatchQueue.main.asyncAfter(deadline: .now() + 120) {
            self.updateHistory()
            self.historyUpdateLoop()
        }
    }
}

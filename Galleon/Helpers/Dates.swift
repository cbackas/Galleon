// Created for Galleon in 2021
// Using Swift 5.0

import Foundation

extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else {
            return nil
        }
        return gregorian.date(byAdding: .day, value: 0, to: sunday)
    }
    
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else {
            return nil
        }
        return gregorian.date(byAdding: .day, value: 6, to: sunday)
    }
    
    var startOfMonth: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let firstDate = gregorian.date(from: gregorian.dateComponents([.year, .month], from: self)) else {
            return nil
        }
        return firstDate
    }
    
    var endOfMonth: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let firstDate = self.startOfMonth else {
            return nil
        }
        guard let daysInMonth = gregorian.range(of: .day, in: .month, for: self) else {
            return nil
        }
        let lastDay = daysInMonth.last!
        return gregorian.date(byAdding: .day, value: lastDay - 1, to: firstDate)
    }
    
    static func datesInRange(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        let calendar = Calendar.current
        
        while date <= toDate {
            if (date == fromDate) {
                var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
                components.hour = 0
                components.minute = 0
                components.second = 0
                
                date = calendar.date(from: components)!
            }

            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            
            dates.append(date)
            date = newDate
        }
        return dates
    }
    
    static func isSameDay(date1: Date, date2: Date) -> Bool {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
    
    static func isSameMonth(date1: Date, date2: Date) -> Bool {
        let date1Month = Calendar.current.component(.month, from: date1)
        let date2Month = Calendar.current.component(.month, from: date2)
        if (date1Month == date2Month) {
            return true
        } else {
            return false
        }
    }
    
    func convertToTimeZone(initTimeZone: TimeZone, timeZone: TimeZone) -> Date {
        let delta = TimeInterval(timeZone.secondsFromGMT(for: self) - initTimeZone.secondsFromGMT(for: self))
        return addingTimeInterval(delta)
    }
}

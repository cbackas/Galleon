// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct HistoryRecord: View {
    var record: SonarrHistoryRecord
    
    var iconSystemName = ""
    var showTitle = ""
    var seasonEpisode = ""
    var episodeTitle = ""
    var quality = ""
    var time = ""
    
    init(record: SonarrHistoryRecord) {
        self.record = record
        
        initIcon()
        self.showTitle = self.record.series!.title!
        self.seasonEpisode = "\(self.record.episode!.seasonNumber!)x\(self.record.episode!.episodeNumber!)"
        self.episodeTitle = self.record.episode!.title!
        self.quality = self.record.quality!.quality!.name!
        initTime()
    }
    
    mutating func initIcon() {
        self.iconSystemName = "square.and.arrow.down"
    }
    
    mutating func initTime() {
        let sourceDateFormatter = DateFormatter()
        sourceDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        let date = sourceDateFormatter.date(from: self.record.date!)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mma"
        timeFormatter.amSymbol = "am"
        timeFormatter.pmSymbol = "pm"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d yyyy"
        
        let cal = Calendar.current
        if (cal.isDateInToday(date!)) {
            self.time = timeFormatter.string(from: date!)
        } else if (cal.isDateInYesterday(date!)) {
            self.time = "Yesterday"
        } else {
            self.time = dateFormatter.string(from: date!)
        }
    }
    
    var body: some View {
        Button(action: {
            print("Did a thing")
        }) {
            HStack {
                Image(systemName: self.iconSystemName)
                Text(self.showTitle)
                Text(self.seasonEpisode)
                Text(self.episodeTitle)
                Text(self.quality)
                Text(self.time)
            }
        }
    }
}

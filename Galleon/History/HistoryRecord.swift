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
        switch self.record.eventType {
        case "grabbed":
            self.iconSystemName = "square.and.arrow.down.fill"
        case "downloadFolderImported":
            self.iconSystemName = "tray.and.arrow.down.fill"
        case "downloadFailed":
            self.iconSystemName = "tray.and.arrow.down.fill"
        case "episodeFileDeleted":
            self.iconSystemName = "trash.fill"
        case "episodeFileRenamed":
            self.iconSystemName = "square.and.pencil"
        case "downloadIgnored":
            self.iconSystemName = "xmark.circle.fill"
        default:
            self.iconSystemName = "square"
        }
    }
    
    mutating func initTime() {
        let sourceDateFormatter = DateFormatter()
        sourceDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        sourceDateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = sourceDateFormatter.date(from: self.record.date!)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mma"
        timeFormatter.timeZone = TimeZone.autoupdatingCurrent
        timeFormatter.amSymbol = "am"
        timeFormatter.pmSymbol = "pm"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d yyyy"
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        
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
                Group {
                    ZStack {
                        Image(systemName: self.iconSystemName)
                            .frame(maxWidth: 33, alignment: .leading)
                            .lineLimit(1)
                            .foregroundColor(self.record.eventType == "downloadFailed" ? Color.red : Color.white)
                            .font(.system(size: 20))
                    }
                    Spacer(minLength: 20)
                    Text(self.showTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                        .font(.system(size: 18))
                    Spacer(minLength: 20)
                    Text(self.seasonEpisode)
                        .frame(maxWidth: 80, alignment: .leading)
                        .lineLimit(1)
                        .font(.system(size: 18))
                    Spacer(minLength: 20)
                }
                Group {
                    Text(self.episodeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                        .font(.system(size: 18))
                    Spacer(minLength: 20)
                    Text(self.quality)
                        .frame(maxWidth: 160, alignment: .trailing)
                        .lineLimit(1)
                        .font(.system(size: 15))
                    Spacer(minLength: 20)
                    Text(self.time)
                        .frame(maxWidth: 160, alignment: .trailing)
                        .lineLimit(1)
                        .font(.system(size: 18))
                }
            }
            .frame(width: 1400)
        }
    }
}

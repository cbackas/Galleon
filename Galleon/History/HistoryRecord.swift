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
    
    var ageMinutes = ""
    var publishedDate = ""
    
    @State var expanded: Bool = false
    
    init(record: SonarrHistoryRecord) {
        self.record = record
        
        initIcon()
        self.showTitle = self.record.series!.title!
        self.seasonEpisode = "\(self.record.episode!.seasonNumber!)x\(self.record.episode!.episodeNumber!)"
        self.episodeTitle = self.record.episode!.title!
        self.quality = self.record.quality!.quality!.name!
        initTime()
        
        let am = record.data!.ageMinutes
        if (am != nil) {
            let numFormatter = NumberFormatter()
            numFormatter.maximumFractionDigits = 0
            numFormatter.roundingMode = .halfUp
            
            let double = Double(record.data!.ageMinutes!)!
            ageMinutes = numFormatter.string(from: NSNumber(value: double))! + " minutes"
        }
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
        
        let publishedFormatter = DateFormatter()
        publishedFormatter.dateFormat = "MMM d yyyy h:mmssa"
        publishedFormatter.timeZone = TimeZone.autoupdatingCurrent
        publishedDate = publishedFormatter.string(from: date!)
    }
    
    var body: some View {
        VStack {
            Button(action: {
                expanded.toggle()
            }) {
                HStack {
                    Group {
                        ZStack {
                            Image(systemName: iconSystemName)
                                .frame(maxWidth: 33, alignment: .leading)
                                .lineLimit(1)
                                .foregroundColor(record.eventType == "downloadFailed" ? Color.red : Color.white)
                                .font(.system(size: 25))
                        }
                        Spacer(minLength: 20)
                        Text(showTitle)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(1)
                            .font(.system(size: 25))
                        Spacer(minLength: 20)
                        Text(seasonEpisode)
                            .frame(maxWidth: 80, alignment: .leading)
                            .lineLimit(1)
                            .font(.system(size: 25))
                        Spacer(minLength: 20)
                    }
                    Group {
                        Text(episodeTitle)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(1)
                            .font(.system(size: 25))
                        Spacer(minLength: 20)
                        Text(quality)
                            .frame(maxWidth: 160, alignment: .trailing)
                            .lineLimit(1)
                            .font(.system(size: 25))
                        Spacer(minLength: 20)
                        Text(time)
                            .frame(maxWidth: 160, alignment: .trailing)
                            .lineLimit(1)
                            .font(.system(size: 25))
                    }
                }
                .frame(width: 1400)
            }
            
            if (expanded) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray)
                        .frame(width: 1400)
                        .zIndex(0)
                    Group {
                        VStack {
                            switch(record.eventType) {
                            case "grabbed":
                                Text("Grabbed")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Divider()
                                
                                HistoryRecordDataItem("Name", record.sourceTitle!)
                                HistoryRecordDataItem("Indexer", record.data!.indexer!)
                                HistoryRecordDataItem("Download Client", record.data!.downloadClientName!)
                                HistoryRecordDataItem("Age (when grabbed)", ageMinutes)
                                HistoryRecordDataItem("Published Date", publishedDate)
                            case "downloadFolderImported":
                                Text("Download Folder Imported")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Divider()
                                
                                HistoryRecordDataItem("Name", record.sourceTitle!)
                                HistoryRecordDataItem("Source", record.data!.droppedPath!)
                                HistoryRecordDataItem("Imported To", record.data!.importedPath!)
                            case "episodeFileDeleted":
                                Text("Episode File Deleted")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Divider()
                                
                                HistoryRecordDataItem("Name", record.sourceTitle!)
                                HistoryRecordDataItem("Reason", record.data?.reason ?? "")
                                HistoryRecordDataItem("Preferred Word Score", record.data!.preferredWordScore!)
                            default:
                               Text("Uh oh")
                            }
                        }
                    }
                    .zIndex(1)
                    .padding(40)
                }
                .frame(width: 1400)
            }
        }
    }
    
    var GrabbedExpansion: some View {
        VStack {
            Text("")
        }
    }
}

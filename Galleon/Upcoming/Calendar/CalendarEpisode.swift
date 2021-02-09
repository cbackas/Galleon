// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct CalendarEpisode: View {
    var episode: SonarrCalendarEntry
    
    var color: Color = Color.blue
    var startTime: String = ""
    var endTime: String = ""
    
    init(episode: SonarrCalendarEntry) {
        self.episode = episode

        let utcTimezone = TimeZone.init(abbreviation: "UTC")!
        let localTimezone = TimeZone.autoupdatingCurrent
        
        let dateTimeFormatUTC = DateFormatter()
        dateTimeFormatUTC.timeZone = utcTimezone
        dateTimeFormatUTC.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        let timeFormat = DateFormatter()
        timeFormat.timeZone = localTimezone
        timeFormat.dateFormat = "h:mma"
        timeFormat.amSymbol = "am"
        timeFormat.pmSymbol = "pm"
        
        // convert string UTC airDate to Date()
        let dateAirDate = dateTimeFormatUTC.date(from: episode.airDateUTC!)
        
        // add runtime (minutes) to the airtime (as a date) and then convert to string
        let dateFinishLocal = dateAirDate!.addingTimeInterval(TimeInterval(episode.series!.runtime! * 60))
        
        self.startTime = timeFormat.string(from: dateAirDate!)
        self.endTime = timeFormat.string(from: dateFinishLocal)
        
        let currentTime = Date()
        if (episode.hasFile!) {
            self.color = Color.green
        } else if (dateFinishLocal <= currentTime) {
            self.color = Color.red
        } else if (dateAirDate! <= currentTime) {
            self.color = Color.yellow
        } else {
            self.color = Color.blue
        }
    }
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 4, style: .continuous)
                .fill(color)
                .frame(width: 4, height: 60)
            VStack {
                HStack {
                    Text(episode.series!.title!)
                        .lineLimit(1)
                        .font(.system(size: 18))
                    Spacer(minLength: 2)
                    Text("\(episode.seasonNumber!)x\(episode.episodeNumber!)")
                        .fixedSize()
                        .font(.system(size: 15))
                }
                HStack {
                    Text(episode.title!)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                        .font(.system(size: 15))
                }
                HStack {
                    Text("\(startTime) - \(endTime)")
                        .font(.system(size: 15))
                    Spacer()
                }
            }
            .padding(.leading, -55)
        }
        .padding(.horizontal, 8)
    }
}

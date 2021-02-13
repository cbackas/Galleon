// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct CalendarEpisode: View {
    var episode: SonarrCalendarEntry
    @ObservedObject var calendarViewModel: CalendarViewModel
    
    var episodeViewModel: EpisodeViewModel = EpisodeViewModel.shared
    
    @State var color: Color = Color.gray
    var dateAirDate: Date
    var dateFinishLocal: Date
    var startTime: String = ""
    var endTime: String = ""
    @State var hasAppeared: Bool = false
    
    init(episode: SonarrCalendarEntry, calendarViewModel: CalendarViewModel) {
        self.episode = episode
        self.calendarViewModel = calendarViewModel
        episodeViewModel.episode = episode

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
        dateAirDate = dateTimeFormatUTC.date(from: episode.airDateUTC!)!
        
        // add runtime (minutes) to the airtime (as a date) and then convert to string
        dateFinishLocal = dateAirDate.addingTimeInterval(TimeInterval(episode.series!.runtime! * 60))
        
        startTime = timeFormat.string(from: dateAirDate)
        endTime = timeFormat.string(from: dateFinishLocal)
    }
    
    func updateColors() {
        let currentTime = Date()
        if (episode.hasFile!) {
            color = Color.green
        } else if (dateFinishLocal <= currentTime) {
            color = Color.red
        } else if (dateAirDate <= currentTime) {
            color = Color.yellow
        } else {
            color = Color.blue
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
        .onAppear() {
            if (!hasAppeared) {
                hasAppeared = true
                updateColors()
            }
        }
        .onChange(of: calendarViewModel.lastCalendarUpdate) { _ in
            updateColors()
        }
        .padding(.horizontal, 8)
    }
}

// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct EpisodeDetail: View {
    @ObservedObject var episodeViewModel: EpisodeViewModel = EpisodeViewModel.shared
    
    var airs: String = ""
    var quality: String = ""
    var episodeSize: String = ""
    
    init() {
        initAirs()
        initQuality()
        initEpisodeSize()
    }
    
    mutating func initAirs() {
        let utcTimezone = TimeZone.init(abbreviation: "UTC")!
        let localTimezone = TimeZone.autoupdatingCurrent
        
        let dateTimeFormatUTC = DateFormatter()
        dateTimeFormatUTC.timeZone = utcTimezone
        dateTimeFormatUTC.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        let dateFormat = DateFormatter()
        dateFormat.timeZone = localTimezone
        dateFormat.dateFormat = "MMM d yyyy"
        
        let timeFormat = DateFormatter()
        timeFormat.timeZone = localTimezone
        timeFormat.dateFormat = "h:mma"
        timeFormat.amSymbol = "am"
        timeFormat.pmSymbol = "pm"
        
        // convert string UTC airDate to Date()
        let dateAirDate = dateTimeFormatUTC.date(from: (episodeViewModel.episode?.airDateUTC!)!)!
        
        let episodeDate = dateFormat.string(from: dateAirDate)
        let episodeTime = timeFormat.string(from: dateAirDate)
        
        airs = "\(episodeDate) at \(episodeTime) on \(episodeViewModel.episode!.series!.network!)"
    }
    
    mutating func initQuality() {
        quality = String((episodeViewModel.episode?.series!.qualityProfileID!)!)
    }
    
    mutating func initEpisodeSize() {
        if ((episodeViewModel.episode?.hasFile!) != nil) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 1
            let sizeBytes: Int = (episodeViewModel.episode?.episodeFile!.size!)!
            let gb = Double(sizeBytes / 1000000000) + (Double(sizeBytes % 1000000000)/1000000000)
            let gbFormatted = formatter.string(from: NSNumber(value: gb))
            episodeSize = "\(gbFormatted!) gb"
        } else {
            episodeSize = ""
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Airs:")
                    .fixedSize()
                    .frame(maxWidth: 250, alignment: .leading)
                    .font(.system(size: 24, weight: .heavy, design: .default))
                Text(airs)
                    .font(.system(size: 24))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            HStack {
                Text("Quality Profile:")
                    .fixedSize()
                    .font(.system(size: 24, weight: .heavy, design: .default))
                    .frame(maxWidth: 250, alignment: .leading)
                Text("Any")
                    .font(.system(size: 24))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            
            Text(episodeViewModel.episode?.overview ?? "No episode overview.")
                .font(.system(size: 24))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 40)
            
            if (episodeViewModel.episode!.hasFile!) {
                VStack {
                    HStack {
                        Text("Path")
                            .font(.system(size: 22, weight: .heavy, design: .default))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Size")
                            .font(.system(size: 22, weight: .heavy, design: .default))
                            .frame(maxWidth: 75, alignment: .leading)
                        Text("Quality")
                            .font(.system(size: 22, weight: .heavy, design: .default))
                            .frame(maxWidth: 250, alignment: .leading)
                    }
                    Divider()
                    
                    HStack {
                        Text(episodeViewModel.episode!.episodeFile!.path!)
                            .font(.system(size: 22))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(episodeSize)
                            .font(.system(size: 22))
                            .frame(maxWidth: 75, alignment: .leading)
                        Text(episodeViewModel.episode!.episodeFile!.quality!.quality!.name!)
                            .font(.system(size: 22))
                            .frame(maxWidth: 250, alignment: .leading)
                    }
                }
                .padding(.top, 40)
            }
            
            Spacer()
        }
    }
}

// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct QueueRecord: View {
    var id: Int
    @State var record: SonarrQueueEntry? = nil
    @ObservedObject var queueViewModel: QueueViewModel
    
    @State var everythingReady: Bool = false
    @State var seriesTitle: String = ""
    @State var seasonNum: String = ""
    @State var episodeNum: String = ""
    @State var episodeTitle: String = ""
    @State var quality: String = ""
    @State var episodeSize: String = ""
    @State var progressValue: Float = 0.0
    @State var timeRemaining: String = ""
    
    @State var hasStatusMessages: Bool = false
    @State var statusMessages: [String] = []
    
    @State var height: CGFloat = 90
    
    func initEpisodeSize() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        let sizeBytes: Int = (record?.size ?? 0)!
        let gb = Double(sizeBytes / 1000000000) + (Double(sizeBytes % 1000000000)/1000000000)
        let gbFormatted = formatter.string(from: NSNumber(value: gb))
        episodeSize = "\(gbFormatted!) GB"
    }
    
    func updateData() {
        let numFormatter = NumberFormatter()
        numFormatter.minimumIntegerDigits = 2
        numFormatter.maximumFractionDigits = 0
        
        everythingReady = false
        
        record = queueViewModel.queue.first { $0.id == id }
        seriesTitle = record?.series?.title ?? ""
        seasonNum = numFormatter.string(for: record?.episode?.seasonNumber ?? 0)!
        episodeNum = numFormatter.string(for: record?.episode?.episodeNumber ?? 0)!
        episodeTitle = record?.episode?.title ?? ""
        quality = record?.quality?.quality?.name ?? ""
        initEpisodeSize()
        
        statusMessages = record?.statusMessages?.first { ($0.title?.contains("S\(seasonNum)E\(episodeNum)") ?? false) }?.messages ?? []
        hasStatusMessages = statusMessages.count > 0
        
        let size = Float(record?.size ?? 0)
        let sizeLeft = Float(record?.sizeleft ?? 0)
        let percentLeft = sizeLeft / size
        progressValue = 1.0 - percentLeft
        timeRemaining = record?.timeleft == "00:00:00" ? "Complete" : record?.timeleft ?? ""
        
        height = 90 + CGFloat(hasStatusMessages ? 60 : 0) + CGFloat(statusMessages.count * 15)
        
        everythingReady = true
    }
    
    var body: some View {
        Button(action: {}) {
            VStack {
                HStack {
                    Text(seriesTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                        .font(.system(size: 27))
                    
                    Spacer()
                    
                    HStack {
                        ProgressBar(value: $progressValue).frame(height: 20)
                        Text(episodeSize)
                            .frame(maxWidth: 100, alignment: .trailing)
                            .lineLimit(1)
                            .font(.system(size: 20))
                    }
                }
                HStack {
                    Text("\(seasonNum)x\(episodeNum) - \(episodeTitle)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                        .font(.system(size: 23))
                    
                    Spacer()
                    
                    HStack {
                        Text(timeRemaining + " left")
                            .frame(maxWidth: 160, alignment: .leading)
                            .lineLimit(1)
                            .font(.system(size: 20))
                        Spacer(minLength: 15)
                        Text(quality)
                            .frame(maxWidth: 160, alignment: .trailing)
                            .lineLimit(1)
                            .font(.system(size: 20))
                        
                    }
                }
                
                if (hasStatusMessages) {
                    Divider()
                    
                    HStack {
                        VStack {
                            Image(systemName: "tray.and.arrow.down.fill")
                                .foregroundColor(Color.orange)
                                .font(.system(size: 20))
                                .padding(.top, 15)
                            Spacer()
                        }
                        VStack {
                            ForEach(statusMessages, id: \.self) {
                                message in
                                Text(message)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .lineLimit(1)
                                    .font(.system(size: 20))
                                    .padding(.leading, -55)
                            }
                        }
                    }
                }
            }
            .frame(width: 1400, height: height)
            .padding(20)
        }
        .buttonStyle(PlainButtonStyle())
        .onAppear() {
            updateData()
        }
        .onChange(of: queueViewModel.lastUpdated) {
            _ in
            updateData()
        }
    }
}

// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct SeriesListItemView: View {
    var series: SonarrSeries
    
    @State var progressValue: Float = 0.0
    @State var progressForeground: Color = Color.primary
    @State var progressBackground: Color = Color.secondary
    
    var body: some View {
        Button(action: { }) {
            HStack {
                Text(series.title!)
                
                Spacer()
                
                ZStack {
                    ProgressBar(value: $progressValue, foregroundColor: progressForeground, backgroundColor: progressBackground)
                        .frame(width: 400, height: 40)
                    Text("\(series.episodeFileCount ?? 0) / \(series.episodeCount ?? 0)")
                        .font(.caption)
                        .frame(alignment: .center)
                }
                .onAppear() {
                    let episodeCount = (series.episodeCount ?? 1) == 0 ? 1 : (series.episodeCount ?? 1)
                    progressValue = Float((series.episodeFileCount ?? 0) / episodeCount)
                    
                    if (progressValue == 1) {
                        if (series.status == "ended") {
                            progressForeground = Color.init(hex: "27c24c")
                            progressBackground = Color.init(hex: "27c24c")
                        } else {
                            progressForeground = Color.init(hex: "5d9cec")
                            progressBackground = Color.init(hex: "5d9cec")
                        }
                    } else {
                        progressForeground = Color.red
                        progressBackground = Color.red
                    }
                }
            }
            .padding(20)
        }
        .padding(.horizontal, 40)
        .buttonStyle(PlainButtonStyle())
    }
}

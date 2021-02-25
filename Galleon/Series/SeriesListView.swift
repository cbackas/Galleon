// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct SeriesListView: View {
    @ObservedObject var seriesViewModel: SeriesViewModel
    
    @State var showDisplayModeSelector: Bool = false
    @State var showFilterSelector: Bool = false
    
    @State var selectedView: String = "List"
    @State var selectedFilter: String = "All"
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {} ) {
                    Image(systemName: "arrow.clockwise")
                }
                
                Spacer()
                
                OptionsPopupButton(title: "View", iconSystemName: "eye.fill", message: "Select desired view style", options: ["List", "Posters", "Overview"], selectedOption: $selectedView)
                OptionsPopupButton(title: "Filter", iconSystemName: "line.horizontal.3.decrease.circle.fill", message: "Select filter mode", options: ["All", "Monitored Only", "Unmonitored Only", "Continuing Only", "Ended Only", "Missing Episodes"], selectedOption: $selectedFilter)
                
            }
            .padding(.top, 10)
            .padding(.horizontal, 40)
            
            ZStack {
                LazyVStack(spacing: 4) {
                    ForEach(seriesViewModel.seriesList, id: \.self) {
                        series in
                        
                        if (series != seriesViewModel.seriesList.first) {
                            Divider()
                        }
                        SeriesListItemView(series: series)
                    }
                }
                GeometryReader { proxy in
                    let offset = proxy.frame(in: .named("scroll")).minY
                    Color.clear.preference(key: ViewOffsetKey.self, value: offset)
                }
            }
        }
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

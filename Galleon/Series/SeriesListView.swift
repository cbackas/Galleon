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
        ScrollView {
            VStack {
                HStack {
                    Button(action: {} ) {
                        Image(systemName: "arrow.clockwise")
                    }
                    
                    Spacer()
                    
                    OptionsPopupButton(title: "View", iconSystemName: "eye.fill", message: "Select desired view style", options: ["List", "Posters", "Overview"], selectedOption: $selectedView)
                    OptionsPopupButton(title: "Filter", iconSystemName: "line.horizontal.3.decrease.circle.fill", message: "Select filter mode", options: ["All", "Monitored Only", "Unmonitored Only", "Continuing Only", "Ended Only", "Missing Episodes"], selectedOption: $selectedFilter)
                    
                }
                .padding(.horizontal, 40)
                
                LazyVStack(spacing: 4) {
                    ForEach(seriesViewModel.seriesList, id: \.self) {
                        series in
                        
                        if (series != seriesViewModel.seriesList.first) {
                            Divider()
                        }
                        
                        SeriesListItemView(series: series)
                    }
                }
            }
        }
        
    }
}

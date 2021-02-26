// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct RootView: View {
    @StateObject var seriesViewModel = SeriesViewModel.shared
    @StateObject var calendarViewModel = CalendarViewModel.shared
    @StateObject var queueViewModel = QueueViewModel.shared
    @StateObject var historyViewModel = HistoryViewModel.shared
    
    @State private var selection = "settings"
    
    var body: some View {
        ScrollView {
            VStack {
                TabSelector(selection: $selection)
                    .border(Color.red)
                
                SelectedView
            }
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder var SelectedView: some View {
        switch (selection) {
        case "series":
            SeriesListView()
        case "calendar":
            UpcomingView()
        case "queue":
            QueueView()
        case "history":
            HistoryView()
        case "settings":
            SettingsView()
                .border(Color.orange)
        default:
            SeriesListView()
        }
    }
}

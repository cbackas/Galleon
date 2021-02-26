// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct RootView: View {
    // do i even need these here
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
                    .border(Color.orange)
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
        default:
            SeriesListView()
        }
    }
}

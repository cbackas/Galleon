// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

@main
struct GalleonApp: App {
    @Environment(\.scenePhase) private var phase
    
    let seriesViewModel = SeriesViewModel()
    let calendarViewModel = CalendarViewModel()
    let queueViewModel = QueueViewModel.shared
    let historyViewModel = HistoryViewModel()
    @State private var selection = "series"
    
    var body: some Scene {
        WindowGroup {
            GeometryReader { geometry in
                TabView(selection: $selection) {
                    SeriesListView(seriesViewModel: seriesViewModel)
                        .tabItem {
                            Text("Series")
                        }
                        .tag("series")
                    UpcomingView(calendarViewModel: calendarViewModel)
                        .tabItem {
                            Text("Calendar")
                        }
                        .tag("calendar")
                    QueueView(queueViewModel: queueViewModel)
                        .tabItem {
                            Text("Queue")
                        }
                        .tag("queue")
                    HistoryView(historyViewModel: historyViewModel)
                        .tabItem {
                            Text("History")
                        }
                        .tag("history")
                    SettingsView()
                        .tabItem {
                            Text("Settings")
                        }
                        .tag("settings")
                }
                .onChange(of: selection) { _ in
                    // when tabs get changed, update the data
                    switch selection {
                    case "series":
                        seriesViewModel.updateData()
                    case "calendar":
                        calendarViewModel.updateData()
                    case "queue":
                        queueViewModel.updateData()
                    case "history":
                        historyViewModel.updateHistory(true)
                    default:
                        break
                    }
                }
            }
        }
        .onChange(of: phase) { newPhase in
            switch newPhase {
            case .active:
                // App became active
                print("active");
            case .inactive:
                // App became inactive
                print("inactive");
            case .background:
                // App is running in the background
                print("background");
            @unknown default:
                // Fallback for future cases
                print("default");
            }
        }
    }
}

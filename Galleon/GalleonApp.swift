// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

@main
struct GalleonApp: App {
    @Environment(\.scenePhase) private var phase
    
    let calendarViewModel = CalendarViewModel()
    let queueViewModel = QueueViewModel()
    let historyViewModel = HistoryViewModel()
    @State private var selection = "calendar"
    
    var body: some Scene {
        WindowGroup {
            GeometryReader { geometry in
                TabView(selection: $selection) {
                    UpcomingView(calendarViewModel: calendarViewModel)
                        .tabItem {
                            Text("Upcoming")
                        }
                        .tag("upcoming")
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
                .onChange(of: selection) {_ in
                    // when tabs get changed, update the data
                    switch selection {
                    case "upcoming":
                        calendarViewModel.updateCalendar()
                    case "queue":
                        break
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

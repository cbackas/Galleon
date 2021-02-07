// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

@main
struct GalleonApp: App {
    @Environment(\.scenePhase) private var phase
    
    let viewModel = ViewModel()
    @State private var selection = "upcoming"

    var body: some Scene {
        WindowGroup {
            GeometryReader { geometry in
                TabView(selection: $selection) {
                    UpcomingView(viewModel: viewModel)
                        .onAppear() {
                            viewModel.getMonthlyEntries()
                        }
                        .tabItem {
                            Text("Upcoming")
                        }
                        .tag("upcoming")
                    HistoryView(viewModel: viewModel)
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

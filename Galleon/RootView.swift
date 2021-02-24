// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct RootView: View {
    let seriesViewModel = SeriesViewModel()
    let calendarViewModel = CalendarViewModel()
    let queueViewModel = QueueViewModel.shared
    let historyViewModel = HistoryViewModel()
    
    @State private var selection = "series"
    
    var body: some View {
        ScrollView {
            VStack {
                Group {
                    HStack {
                        Button(action: {
                            print("SEARCH")
                        }) {
                            Image(systemName: "magnifyingglass")
                                .padding(10)
                        }
                        .buttonStyle(PlainButtonStyle())
                        TabButton(selected: selection == "series", action: {
                            selection = "series"
                        }) {
                            Text("Series")
                        }
                        TabButton(selected: selection == "calendar", action: {
                            selection = "calendar"
                        }) {
                            Text("Calendar")
                        }
                        TabButton(selected: selection == "queue", action: {
                            selection = "queue"
                        }) {
                            Text("Queue")
                        }
                        TabButton(selected: selection == "history", action: {
                            selection = "history"
                        }) {
                            Text("History")
                        }
                        TabButton(selected: selection == "settings", action: {
                            selection = "settings"
                        }) {
                            Text("Settings")
                        }
                        
                        Spacer()
                        
                        CurrentTime()
                    }
                    .padding(35)
                }
                .frame(width: 1920)
                .ignoresSafeArea()
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
                
                Group {
                    //the rest of things
                    switch (selection) {
                    case "series":
                        SeriesListView(seriesViewModel: seriesViewModel)
                    case "calendar":
                        UpcomingView(calendarViewModel: calendarViewModel)
                    case "queue":
                        QueueView(queueViewModel: queueViewModel)
                    case "history":
                        HistoryView(historyViewModel: historyViewModel)
                    case "settings":
                        SettingsView()
                    default:
                        SeriesListView(seriesViewModel: seriesViewModel)
                    }
                }
            }
        }
    }
}

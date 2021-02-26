// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct TabSelector: View {
    @Binding var selection: String
    
    var body: some View {
        HStack {
            HStack(spacing: 40) {
                Button(action: {
                    print("SEARCH")
                }) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 35))
                        .padding(10)
                        .ignoresSafeArea()
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.leading, 35)
                
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
                    .padding(.trailing, 35)
            }
        }
        .frame(width: 1920, height: 150, alignment: .center)
        .padding(.bottom, 0)
        .ignoresSafeArea()
        .onChange(of: selection, perform: onSelectionChange)
    }
    
    func onSelectionChange(_ newChoice: String) {
        // when tabs get changed, update the data
        switch newChoice {
        case "series":
            SeriesViewModel.shared.updateData()
        case "calendar":
            CalendarViewModel.shared.updateData()
        case "queue":
            QueueViewModel.shared.updateData()
        case "history":
            HistoryViewModel.shared.updateHistory(true)
        default:
            break
        }
    }
}

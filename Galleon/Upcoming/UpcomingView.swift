// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct UpcomingView: View {
    @ObservedObject var viewModel: ViewModel
    @State var currentView = "calendar"
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Button(action: {
                        print("Back")
                        moveMonth(-1)
                    }) {
                        Image(systemName: "chevron.backward.2")
                    }
                    .buttonStyle(PlainButtonStyle())
                    Button(action: {
                        print("Today")
                        self.moveMonth(nil)
                    }) {
                        Text("Today")
                    }
                    .buttonStyle(DefaultButtonStyle())
                    .padding(.horizontal, -20)
                    Button(action: {
                        self.moveMonth(1)
                    }) {
                        Image(systemName: "chevron.forward.2")
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        print("thing")
                    }) {
                        HStack {
                            Spacer()
                            Text(self.viewModel.calendarHeading)
                                .font(.headline)
                            Spacer()
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        if (currentView == "calendar") {
                            currentView = "agenda"
                        } else if (currentView == "agenda") {
                            currentView = "calendar"
                        }
                    }) {
                        if (currentView == "calendar") {
                            Text("Agenda")
                        } else if (currentView == "agenda") {
                            Text("Calendar")
                        }
                    }
                }
                .padding(.horizontal, 60)
                
                switch currentView {
                case "calendar":
                    CalendarView(viewModel: viewModel)
                case "agenda":
                    AgendaView()
                default:
                    CalendarView(viewModel: viewModel)
                }
            }
        } // scrollview
    }
    
    func moveMonth(_ amount: Int?) {
        if (amount == nil) {
            self.viewModel.calendarMonth = Date()
        } else {
            self.viewModel.calendarMonth = Calendar.current.date(byAdding: .month, value: amount!, to: self.viewModel.calendarMonth)!
        }
        self.viewModel.updateCalendar()
    }
}

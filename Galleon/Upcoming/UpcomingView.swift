// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct UpcomingView: View {
    @ObservedObject var calendarViewModel: CalendarViewModel
    
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
                        moveMonth(nil)
                    }) {
                        Text("Today")
                    }
                    .buttonStyle(DefaultButtonStyle())
                    .padding(.horizontal, -20)
                    Button(action: {
                        moveMonth(1)
                    }) {
                        Image(systemName: "chevron.forward.2")
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        print("thing")
                    }) {
                        HStack {
                            Spacer()
                            Text(calendarViewModel.calendarHeading)
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
                    CalendarView(calendarViewModel: calendarViewModel)
                case "agenda":
                    AgendaView()
                default:
                    CalendarView(calendarViewModel: calendarViewModel)
                }
            }
        } // scrollview
    }
    
    func moveMonth(_ amount: Int?) {
        if (amount == nil) {
            calendarViewModel.calendarMonth = Date()
        } else {
            calendarViewModel.calendarMonth = Calendar.current.date(byAdding: .month, value: amount!, to: calendarViewModel.calendarMonth)!
        }
        calendarViewModel.updateCalendar()
    }
}

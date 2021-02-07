// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct UpcomingView: View {
    @ObservedObject var viewModel: ViewModel
    @State var currentView = "calendar"
    
    var monthHeading = "Month - Year"
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL yyyy"
        monthHeading = dateFormatter.string(from: date)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Button(action: {
                        print("Back")
                    }) {
                        Image(systemName: "chevron.backward.2")
                    }
                    .buttonStyle(PlainButtonStyle())
                    Button(action: {
                        print("Today")
                    }) {
                        Text("Today")
                    }
                    .buttonStyle(DefaultButtonStyle())
                    .padding(.horizontal, -20)
                    Button(action: {
                        print("Forward")
                    }) {
                        Image(systemName: "chevron.forward.2")
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        print("thing")
                    }) {
                        HStack {
                            Spacer()
                            Text(monthHeading)
                            Spacer()
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    //                    .frame(width: 1000)
                    
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
                //                .border(Color.yellow)
                
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
}

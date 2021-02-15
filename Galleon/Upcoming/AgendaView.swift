// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct AgendaView: View {
    var body: some View {
        VStack {
            ScrollView { // this scrollview improves scroll performance
                VStack(spacing: 10) {
//                    Text(dateHeading)
//                        .font(.headline)
//                        .preferredColorScheme(.dark)
//                        .frame(alignment: .center)
//                    ForEach(episodeEntries ?? (calendarViewModel.visibleEntries.first?.episodeEntries ?? []), id: \.self) {
//                        episode in
//                        CalendarEpisodeViewButton(episode: episode, calendarViewModel: calendarViewModel)
//                    }
                    Text("Agenda View")
                }
                .frame(width: 1850)
                .padding(.horizontal, 40)
                .padding(.bottom, 80)
                .edgesIgnoringSafeArea(.horizontal)
                .edgesIgnoringSafeArea(.top)
            }
        }
    }
}

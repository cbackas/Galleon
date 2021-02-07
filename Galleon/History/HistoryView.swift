// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: ViewModel
    
    @State var showingPage = 1
    var historyEntries: [SonarrHistoryRecord] = []
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        historyEntries = self.viewModel.historyData.first {
            $0.page == self.showingPage
        }?.records ?? []
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(historyEntries, id: \.self) {
                    entry in

                }
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.showingPage -= 1
                    }) {
                        Image(systemName: "chevron.backward.2")
                    }
                    .disabled(showingPage == 1)
                    .buttonStyle(PlainButtonStyle())
                    
                    Text("\(showingPage)/1500")
                        
                    .padding(.horizontal, -20)
                    Button(action: {
                        self.showingPage += 1
                    }) {
                        Image(systemName: "chevron.forward.2")
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                }
            }
        }
    }
}

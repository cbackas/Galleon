// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct HistoryPaginator: View {
    @ObservedObject var historyViewModel: HistoryViewModel
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: {
                historyViewModel.selectedHistoryPage = 1
                historyViewModel.updateHistory(true)
            }) {
                Image(systemName: "chevron.backward.2")
            }
            .disabled(historyViewModel.selectedHistoryPage == 1)
            .buttonStyle(PlainButtonStyle())
            
            Button(action: {
                historyViewModel.selectedHistoryPage -= 1
                historyViewModel.updateHistory(true)
            }) {
                Image(systemName: "chevron.backward")
            }
            .disabled(historyViewModel.selectedHistoryPage == 1)
            .buttonStyle(PlainButtonStyle())
            
            Group {
                if (historyViewModel.historyLoaded) {
                    Text("\(historyViewModel.selectedHistoryPage) / \(historyViewModel.totalHistoryPages)")
                } else {
                    ProgressView()
                        .scaleEffect(x: 0.8, y: 0.8, anchor: .center)
                }
            }
            .frame(minWidth: 200, minHeight: 50, alignment: .center)
            .padding(.vertical, 15)
            .padding(.horizontal, -20)
            
            Button(action: {
                historyViewModel.selectedHistoryPage += 1
                historyViewModel.updateHistory(true)
                
            }) {
                Image(systemName: "chevron.forward")
            }
            .disabled(historyViewModel.selectedHistoryPage == historyViewModel.totalHistoryPages)
            .buttonStyle(PlainButtonStyle())
            
            Button(action: {
                historyViewModel.selectedHistoryPage = historyViewModel.totalHistoryPages
                historyViewModel.updateHistory(true)
                
            }) {
                Image(systemName: "chevron.forward.2")
            }
            .disabled(historyViewModel.selectedHistoryPage == historyViewModel.totalHistoryPages)
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
        }
    }
}

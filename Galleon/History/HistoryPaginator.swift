// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct HistoryPaginator: View {
    @ObservedObject var historyVM = HistoryViewModel.shared
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: {
                historyVM.selectedHistoryPage = 1
                historyVM.updateHistory(true)
            }) {
                Image(systemName: "chevron.backward.2")
            }
            .disabled(historyVM.selectedHistoryPage == 1)
            .buttonStyle(PlainButtonStyle())
            
            Button(action: {
                historyVM.selectedHistoryPage -= 1
                historyVM.updateHistory(true)
            }) {
                Image(systemName: "chevron.backward")
            }
            .disabled(historyVM.selectedHistoryPage == 1)
            .buttonStyle(PlainButtonStyle())
            
            Group {
                if (historyVM.historyLoaded) {
                    Text("\(historyVM.selectedHistoryPage) / \(historyVM.totalHistoryPages)")
                } else {
                    ProgressView()
                        .scaleEffect(x: 0.8, y: 0.8, anchor: .center)
                }
            }
            .frame(minWidth: 200, minHeight: 50, alignment: .center)
            .padding(.vertical, 15)
            .padding(.horizontal, -20)
            
            Button(action: {
                historyVM.selectedHistoryPage += 1
                historyVM.updateHistory(true)
                
            }) {
                Image(systemName: "chevron.forward")
            }
            .disabled(historyVM.selectedHistoryPage == historyVM.totalHistoryPages)
            .buttonStyle(PlainButtonStyle())
            
            Button(action: {
                historyVM.selectedHistoryPage = historyVM.totalHistoryPages
                historyVM.updateHistory(true)
                
            }) {
                Image(systemName: "chevron.forward.2")
            }
            .disabled(historyVM.selectedHistoryPage == historyVM.totalHistoryPages)
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
        }
    }
}

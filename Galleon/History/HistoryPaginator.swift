// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct HistoryPaginator: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: {
                self.viewModel.selectedHistoryPage = 1
                self.viewModel.updateHistory(true)
            }) {
                Image(systemName: "chevron.backward.2")
            }
            .disabled(self.viewModel.selectedHistoryPage == 1)
            .buttonStyle(PlainButtonStyle())
            
            Button(action: {
                self.viewModel.selectedHistoryPage -= 1
                self.viewModel.updateHistory(true)
            }) {
                Image(systemName: "chevron.backward")
            }
            .disabled(self.viewModel.selectedHistoryPage == 1)
            .buttonStyle(PlainButtonStyle())
            
            Group {
                if (self.viewModel.historyLoaded) {
                    Text("\(self.viewModel.selectedHistoryPage) / \(self.viewModel.totalHistoryPages)")
                } else {
                    ProgressView()
                        .scaleEffect(x: 0.8, y: 0.8, anchor: .center)
                }
            }
            .frame(minWidth: 200, minHeight: 50, alignment: .center)
            .padding(.vertical, 15)
            .padding(.horizontal, -20)
            
            Button(action: {
                self.viewModel.selectedHistoryPage += 1
                self.viewModel.updateHistory(true)
                
            }) {
                Image(systemName: "chevron.forward")
            }
            .disabled(self.viewModel.selectedHistoryPage == self.viewModel.totalHistoryPages)
            .buttonStyle(PlainButtonStyle())
            
            Button(action: {
                self.viewModel.selectedHistoryPage = self.viewModel.totalHistoryPages
                self.viewModel.updateHistory(true)
                
            }) {
                Image(systemName: "chevron.forward.2")
            }
            .disabled(self.viewModel.selectedHistoryPage == self.viewModel.totalHistoryPages)
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
        }
    }
}

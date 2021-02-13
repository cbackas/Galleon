// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct HistoryView: View {
    @ObservedObject var historyViewModel: HistoryViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                HistoryPaginator(historyViewModel: historyViewModel)
                
                ForEach(historyViewModel.visibleHistory?.records ?? [], id: \.id) {
                    entry in
                    HistoryRecord(record: entry)
                }
                
                HistoryPaginator(historyViewModel: historyViewModel)
            }
        } // scrollview
    }
}

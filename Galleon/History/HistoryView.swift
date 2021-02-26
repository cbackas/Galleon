// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct HistoryView: View {
    @ObservedObject var historyVM = HistoryViewModel.shared
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            LazyVStack {
                HistoryPaginator()
                
                ForEach(historyVM.visibleHistory?.records ?? [], id: \.id) {
                    entry in
                    HistoryRecord(record: entry)
                }
                
                HistoryPaginator()
            }
        } // scrollview
    }
}

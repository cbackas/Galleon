// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                HistoryPaginator(viewModel: self.viewModel)
                
                ForEach(self.viewModel.visibleHistory?.records ?? [], id: \.id) {
                    entry in
                    HistoryRecord(record: entry)
                }
                
                HistoryPaginator(viewModel: self.viewModel)
            }
        } // scrollview
    }
}

// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct QueueView: View {
    @ObservedObject var queueViewModel: QueueViewModel
    
    var body: some View {
        if (queueViewModel.queue.isEmpty) {
            Text("Queue is empty")
        } else {
            ScrollView {
                VStack(spacing: 10) {
                    Text("Queue")
                        .font(.headline)
                        .preferredColorScheme(.dark)
                        .frame(alignment: .center)
                        .padding(.bottom, 30)
                    
                    ForEach(queueViewModel.queue) {
                        entry in
                        if (entry != queueViewModel.queue.first) {
                            Divider()
                        }
                        QueueRecord(id: entry.id!, queueViewModel: queueViewModel)
                    }
                }
                .padding(60)
            }
        }
    }
}

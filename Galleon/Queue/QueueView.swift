// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct QueueView: View {
    @ObservedObject var queueVM = QueueViewModel.shared
    
    var body: some View {
        if (queueVM.queue.isEmpty) {
            Text("Queue is empty")
        } else {
            ScrollView {
                VStack(spacing: 10) {
                    Text("Queue")
                        .font(.headline)
                        .preferredColorScheme(.dark)
                        .frame(alignment: .center)
                        .padding(.bottom, 30)
                    
                    ForEach(queueVM.queue) {
                        entry in
                        if (entry != queueVM.queue.first) {
                            Divider()
                        }
                        QueueRecord(id: entry.id!)
                    }
                }
                .padding(60)
            }
        }
    }
}

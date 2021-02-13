// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct HistoryRecordDataItem: View {
    var title: String
    var value: String
    
    init(_ title: String, _ value: String) {
        self.title = title
        self.value = value
    }
    
    var body: some View {
        HStack {
            Text(title)
                .frame(maxWidth: 350, alignment: .trailing)
                .font(.system(size: 25, weight: .heavy, design: .default))
            Text(value)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 25))
                .lineLimit(3)
        }
    }
}

// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct TabButton<Content: View>: View {
    var selected: Bool?
    var content: Content
    var action: () -> Void
    
    init(selected: Bool? = nil, action: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.selected = selected
        self.action = action
        self.content = content()
    }
    
    var body: some View {
        Button(action: {
            action()
        }) {
            VStack {
                content
                    .padding(.top, 10)
                    .padding(.bottom, -20)
                if (selected != nil) {
                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                        .fill(selected! ? Color.primary : Color.primary.opacity(0))
                        .frame(width: 120, height: 4, alignment: .center)
                }
            }
            .padding(10)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

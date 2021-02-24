// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct ProgressBar: View {
    @Binding var value: Float
    
    var foregroundColor: Color = Color.primary
    var backgroundColor: Color = Color.secondary
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(foregroundColor)
                
                Rectangle()
                    .frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(backgroundColor)
                    .animation(.linear)
            }.cornerRadius(45.0)
        }
    }
}

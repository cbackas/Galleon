// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct CurrentTime: View {
    @State var timeNow = ""
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var dateFormatter: DateFormatter {
        let fmtr = DateFormatter()
        fmtr.dateFormat = "h:mm a"
        fmtr.amSymbol = "am"
        fmtr.pmSymbol = "pm"
        return fmtr
    }
    
    var body: some View {
        Text(timeNow)
            .onReceive(timer) { _ in
                self.timeNow = dateFormatter.string(from: Date())
            }
    }
}

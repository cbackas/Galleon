// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct CalendarLegend: View {
    var body: some View {
        HStack {
            HStack {
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .fill(Color.blue)
                    .frame(width: 4, height: 20)
                Text("Unaired")
                    .padding(.leading, -55)
                    .font(.system(size: 15))
            }
            HStack {
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .fill(Color.yellow)
                    .frame(width: 4, height: 20)
                Text("On Air")
                    .padding(.leading, -55)
                    .font(.system(size: 15))
            }
            HStack {
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .fill(Color.red)
                    .frame(width: 4, height: 20)
                Text("Missing")
                    .padding(.leading, -55)
                    .font(.system(size: 15))
            }
            HStack {
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .fill(Color.green)
                    .frame(width: 4, height: 20)
                Text("Downloaded")
                    .padding(.leading, -55)
                    .font(.system(size: 15))
            }
            HStack {
                Image(systemName: "flag.fill")
                    .foregroundColor(Color(UIColor.systemTeal))
                    .font(.system(size: 15))
                Text("Premiere")
                    .padding(.leading, -55)
                    .font(.system(size: 15))
            }
            HStack {
                Image(systemName: "bolt.horizontal.fill")
                    .foregroundColor(.orange)
                    .font(.system(size: 15))
                Text("Cutoff Not Met")
                    .padding(.leading, -55)
                    .font(.system(size: 15))
            }
        }
    }
}

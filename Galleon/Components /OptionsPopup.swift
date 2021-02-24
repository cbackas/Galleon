// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct OptionsPopupButton: View {
    @State var title: String
    @State var iconSystemName: String? = nil
    @State var message: String? = nil
    @State var options: [String]
    @Binding var selectedOption: String
    
    @State var showPopup: Bool = false
    
    func buttons() -> [Alert.Button] {
        var buttons: [Alert.Button] = []
        
        options.forEach() {
            option in
            let optionText = option + ((option == selectedOption ? "     ⎷" : ""))
            buttons.append(
                .default(Text(optionText)) {
                self.selectedOption = option
            })
        }
        
        buttons.append(.cancel())
        
        return buttons
    }
    
    var body: some View {
        Button(action: {
            showPopup = true
        }) {
            if (iconSystemName != nil) {
                Image(systemName: iconSystemName!)
            } else {
                Text(title)
            }
        }
        .actionSheet(isPresented: $showPopup) {
            ActionSheet(title: Text(title), message: Text(message ?? ""), buttons: buttons())
        }
        
//        VStack {
//            Text("View")
//                .font(.headline)
//
//            Spacer(minLength: 100)
//
//            ForEach(options, id: \.self) {
//                option in
//                Button(action: {
//                    selectedOption = option
//                } ) {
//                    Text(option)
//                }
//            }
//
//            Spacer()
//        }
    }
}

// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

extension Binding {
    func onChange (_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}

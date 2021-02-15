// Created for Galleon in 2021
// Using Swift 5.0

import Foundation

/*
 / View states
 */
extension StorageManager {
    public func getUpcomingViewSelection() -> String {
        guard let loadedStr = UserDefaults.standard.object(forKey: "upcoming_view_selection")
                as? String else {
            saveUpcomingViewSelection(viewSelection: "month")
            return "month"
        }
        return loadedStr
    }
    
    public func saveUpcomingViewSelection(viewSelection: String) -> Void {
        self.saveData("upcoming_view_selection", viewSelection)
    }
}

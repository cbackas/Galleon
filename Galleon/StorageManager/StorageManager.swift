// Created for Galleon in 2021
// Using Swift 5.0

import Foundation

public class StorageManager {
    public static let instance: StorageManager = {
        let instance = StorageManager()
        return instance
    }()
    
    public func resetStorage() -> Void {
        UserDefaults.standard.removeObject(forKey: "sonarr_api_key")
        UserDefaults.standard.removeObject(forKey: "sonarr_token")
        UserDefaults.standard.removeObject(forKey: "sonarr_url")
        UserDefaults.resetStandardUserDefaults()
    }
    
    func saveData(_ key: String, _ value: String?) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.resetStandardUserDefaults()
    }
}

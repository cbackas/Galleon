// Created for Galleon in 2021
// Using Swift 5.0

import Foundation

/*
 / Sonarr Config
 */
extension StorageManager {
    public func getAPIKeyFromStorage() -> String? {
        guard let loadedStr = UserDefaults.standard.object(forKey: "sonarr_api_key")
                as? String else {
            return nil
        }
        return loadedStr
    }
    
    public func saveAPIKeyToStorage(api_key: String) -> Void {
        self.saveData("sonarr_api_key", api_key)
    }
    
    public func getServerURLFromStorage() -> String? {
        guard let loadedStr = UserDefaults.standard.object(forKey: "sonarr_url")
                as? String else {
            return nil
        }
        return loadedStr
    }
    
    public func saveServerURLToStorage(url: String) -> Void {
        self.saveData("sonarr_url", url)
    }
}

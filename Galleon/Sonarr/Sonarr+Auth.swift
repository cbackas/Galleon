// Created for Galleon in 2021
// Using Swift 5.0

import Foundation

extension SonarrComm {
    public func getAPIKeyFromStorage() -> String? {
        guard let loadedKey = UserDefaults.standard.object(forKey: "sonarr_api_key")
                as? String else {
            return nil
        }
        return loadedKey
    }
    
    public func saveAPIKeyToStorage(api_key: String) -> Void {
        UserDefaults.standard.set(api_key, forKey: "sonarr_api_key")
        UserDefaults.resetStandardUserDefaults()
    }
    
    public func getServerURLFromStorage() -> String? {
        guard let loadedURL = UserDefaults.standard.object(forKey: "sonarr_url")
                as? String else {
            return nil
        }
        return loadedURL
    }
    
    public func saveServerURLToStorage(url: String) -> Void {
        UserDefaults.standard.set(url, forKey: "sonarr_url")
        UserDefaults.resetStandardUserDefaults()
    }
    
    public func resetStorage() -> Void {
        UserDefaults.standard.removeObject(forKey: "sonarr_api_key")
        UserDefaults.standard.removeObject(forKey: "sonarr_token")
        UserDefaults.standard.removeObject(forKey: "sonarr_url")
        UserDefaults.resetStandardUserDefaults()
    }
}

// Created for Galleon in 2021
// Using Swift 5.0

import SwiftUI

struct SettingsView: View {
    @State var sonarrURL: String = ""
    @State var apiKey: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Sonarr")) {
                VStack {
                    TextField("Sonarr URL", text: $sonarrURL, onEditingChanged: { _ in
                    }, onCommit: {
                        saveSettings()
                    })
                    HStack {
                        Text("http://<IP_ADDR>:<PORT>")
                            .font(.caption2)
                        Spacer()
                    }
                }
                
                VStack {
                    TextField("API Key", text: $apiKey, onEditingChanged: { _ in
                    }, onCommit: {
                        saveSettings()
                    })
                    HStack {
                        Text("Found in Settings -> General -> Security")
                            .font(.caption2)
                        Spacer()
                    }
                }
                
                Button(action: getServerStatus) {
                    Text("Test Sonarr Connection")
                }
            }
            
            Section(header: Text("Tests")) {
                Button(action: saveSettings) {
                    Text("Test saving things")
                }
                Button(action: loadStoredSettings) {
                    Text("Test reading things")
                }
                Button(action: resetSetting) {
                    Text("Test resetting things")
                }
            }
        }
        .frame(width: 1920, height: 930)
        .onAppear(perform: loadStoredSettings)
    }
    
    func getServerStatus() {
        SonarrComm.shared.getServerStatus() {
            sonarrStatus, errorDescription in
            if (errorDescription != nil) {
                print("lol error: \(errorDescription!)")
            } else {
                print(sonarrStatus!)
            }
        }
    }
    
    func resetSetting() {
        StorageManager.instance.resetStorage()
        sonarrURL = ""
        apiKey = ""
        print("Reset the things")
    }
    
    func loadStoredSettings() {
        sonarrURL = StorageManager.instance.getServerURLFromStorage() ?? ""
        apiKey = StorageManager.instance.getAPIKeyFromStorage() ?? ""
        print("Reading the things: ", sonarrURL, apiKey)
    }
    
    func saveSettings() {
        StorageManager.instance.saveServerURLToStorage(url: sonarrURL)
        StorageManager.instance.saveAPIKeyToStorage(api_key: apiKey)
        print("Tried to save the things")
    }
}

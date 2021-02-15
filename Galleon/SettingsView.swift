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
                
                Button(action: {
                    SonarrComm.shared.getServerStatus() {
                        sonarrStatus, errorDescription in
                        if (errorDescription != nil) {
                            print("lol error: \(errorDescription!)")
                        } else {
                            print(sonarrStatus!)
                        }
                    }
                }) {
                    Text("Test Sonarr Connection")
                }
            }
            
            Section(header: Text("Tests")) {
                Button(action: {
                    saveSettings()
                }) {
                    Text("Test saving things")
                }
                Button(action: {
                    loadStoredSettings()
                }) {
                    Text("Test reading things")
                }
                Button(action: {
                    StorageManager.instance.resetStorage()
                    sonarrURL = ""
                    apiKey = ""
                    print("Reset the things")
                }) {
                    Text("Test resetting things")
                }
            }
        }
        .onAppear() {
            loadStoredSettings()
        }
    }
    
    private func loadStoredSettings() -> Void {
        sonarrURL = StorageManager.instance.getServerURLFromStorage() ?? ""
        apiKey = StorageManager.instance.getAPIKeyFromStorage() ?? ""
        print("Reading the things: ", sonarrURL, apiKey)
    }
    
    private func saveSettings() -> Void {
        StorageManager.instance.saveServerURLToStorage(url: sonarrURL)
        StorageManager.instance.saveAPIKeyToStorage(api_key: apiKey)
        print("Tried to save the things")
    }
}

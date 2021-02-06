// Created for Galleon in 2021
// Using Swift 5.0

import Foundation

// MARK: - SonarrStatus
public struct SonarrStatus: Codable {
    var version, buildTime: String?
    var isDebug, isProduction, isAdmin, isUserInteractive: Bool?
    var startupPath, appData, osName, osVersion: String?
    var isMonoRuntime, isMono, isLinux, isOsx: Bool?
    var isWindows: Bool?
    var branch, authentication, sqliteVersion, urlBase: String?
    var runtimeVersion, runtimeName: String?
}

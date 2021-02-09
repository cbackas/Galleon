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

// MARK: - SonarrSeries
public struct SonarrSeries: Codable, Hashable {
    var title, sortTitle: String?
    var seasonCount: Int?
    var status, overview, network, airTime: String?
    var images: [SonarrImage]?
    var seasons: [SonarrSeason]?
    var year: Int?
    var path: String?
    var profileID, languageProfileID: Int?
    var seasonFolder, monitored, useSceneNumbering: Bool?
    var runtime, tvdbID, tvRageID, tvMazeID: Int?
    var firstAired, lastInfoSync, seriesType, cleanTitle: String?
    var imdbID, titleSlug, certification: String?
    var genres, tags: [String]?
    var added: String?
    var ratings: SonarrRatings?
    var qualityProfileID, id: Int?
    
    enum CodingKeys: String, CodingKey {
        case title, sortTitle, seasonCount, status, overview, network, airTime, images, seasons, year, path
        case profileID = "profileId"
        case languageProfileID = "languageProfileId"
        case seasonFolder, monitored, useSceneNumbering, runtime
        case tvdbID = "tvdbId"
        case tvRageID = "tvRageId"
        case tvMazeID = "tvMazeId"
        case firstAired, lastInfoSync, seriesType, cleanTitle
        case imdbID = "imdbId"
        case titleSlug, certification, genres, tags, added, ratings
        case qualityProfileID = "qualityProfileId"
        case id
    }
}

// MARK: - SonarrEpisodeFileQuality
public struct SonarrEpisodeFileQuality: Codable, Hashable {
    var quality: SonarrQualityQuality?
    var revision: SonarrRevision?
}

// MARK: - SonarrImage
public struct SonarrImage: Codable, Hashable {
    var coverType: SonarrCoverType?
    var url: String?
}

// MARK: - SonarrRatings
public struct SonarrRatings: Codable, Hashable {
    var votes: Int?
    var value: Double?
}

// MARK: - SonarrSeason
public struct SonarrSeason: Codable, Hashable {
    var seasonNumber: Int?
    var monitored: Bool?
}

// MARK: - SonarrRevision
public struct SonarrRevision: Codable, Hashable {
    var version, real: Int?
    var isRepack: Bool?
    
    public static func == (lhs: SonarrRevision, rhs: SonarrRevision) -> Bool {
        lhs.version == rhs.version && lhs.real == rhs.real && lhs.isRepack == rhs.isRepack
    }
}

// MARK: - SonarrQualityQuality
public struct SonarrQualityQuality: Codable, Hashable {
    var id: Int?
    var name, source: String?
    var resolution: Int?
    
    public static func == (lhs: SonarrQualityQuality, rhs: SonarrQualityQuality) -> Bool {
        lhs.id == rhs.id
    }
}

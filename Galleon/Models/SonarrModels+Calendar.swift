// Created for Galleon in 2021
// Using Swift 5.0

import Foundation
import SwiftUI

public struct CalDayData: Hashable {
//    public var id: UUID
    let date: Date
    var episodeEntries: [SonarrCalendarEntry]?
    let row: Int
    var height: CGFloat
    
    public static func == (lhs: CalDayData, rhs: CalDayData) -> Bool {
        return lhs.date == rhs.date
    }
}

// MARK: - SonarrCalendarElement
public struct SonarrCalendarEntry: Codable, Hashable {
    public static func == (lhs: SonarrCalendarEntry, rhs: SonarrCalendarEntry) -> Bool {
        return lhs.id == rhs.id
    }
    
    var seriesID, episodeFileID, seasonNumber, episodeNumber: Int?
    var title, airDate, airDateUTC, overview: String?
    var episodeFile: SonarrEpisodeFile?
    var hasFile, monitored, unverifiedSceneNumbering: Bool?
    var series: SonarrEpisodeSeries?
    var id, absoluteEpisodeNumber: Int?
    
    enum CodingKeys: String, CodingKey {
        case seriesID = "seriesId"
        case episodeFileID = "episodeFileId"
        case seasonNumber, episodeNumber, title, airDate
        case airDateUTC = "airDateUtc"
        case overview, episodeFile, hasFile, monitored, unverifiedSceneNumbering, series, id, absoluteEpisodeNumber
    }
}

// MARK: - SonarrEpisodeFile
public struct SonarrEpisodeFile: Codable, Hashable {
    public static func == (lhs: SonarrEpisodeFile, rhs: SonarrEpisodeFile) -> Bool {
        return lhs.id == rhs.id
    }
    
    var seriesID, seasonNumber: Int?
    var relativePath, path: String?
    var size: Int?
    var dateAdded, sceneName: String?
    var quality: SonarrEpisodeFileQuality?
    var language: SonarrLanguage?
    var mediaInfo: SonarrMediaInfo?
    var originalFilePath: String?
    var qualityCutoffNotMet: Bool?
    var id: Int?
    
    enum CodingKeys: String, CodingKey {
        case seriesID = "seriesId"
        case seasonNumber, relativePath, path, size, dateAdded, sceneName, quality, language, mediaInfo, originalFilePath, qualityCutoffNotMet, id
    }
}

// MARK: - SonarrLanguage
public struct SonarrLanguage: Codable, Hashable {
    var id: Int?
    var name: String?
}

// MARK: - SonarrMediaInfo
public struct SonarrMediaInfo: Codable, Hashable {
    var audioChannels: Double?
    var audioCodec, videoCodec: String?
}

public enum SonarrCoverType: String, Codable, Hashable {
    case banner = "banner"
    case fanart = "fanart"
    case poster = "poster"
}

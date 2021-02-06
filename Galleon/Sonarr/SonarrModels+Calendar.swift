// Created for Galleon in 2021
// Using Swift 5.0

import Foundation
import SwiftUI

public struct CalDayData: Hashable {    
    public static func == (lhs: CalDayData, rhs: CalDayData) -> Bool {
        return lhs.date == rhs.date
    }
    
    let date: Date
    var episodeEntries: [SonarrCalendarEntry]?
    let calendarRow: Int
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
    var series: SonarrSeries?
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

// MARK: - SonarrEpisodeFileQuality
public struct SonarrEpisodeFileQuality: Codable, Hashable {
    var quality: SonarrQualityQuality?
    var revision: SonarrRevision?
}

// MARK: - SonarrQualityQuality
public struct SonarrQualityQuality: Codable, Hashable {
    var id: Int?
    var name, source: String?
    var resolution: Int?
}

// MARK: - SonarrRevision
public struct SonarrRevision: Codable, Hashable {
    var version, real: Int?
    var isRepack: Bool?
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

// MARK: - SonarrImage
public struct SonarrImage: Codable, Hashable {
    var coverType: SonarrCoverType?
    var url: String?
}

public enum SonarrCoverType: String, Codable, Hashable {
    case banner = "banner"
    case fanart = "fanart"
    case poster = "poster"
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

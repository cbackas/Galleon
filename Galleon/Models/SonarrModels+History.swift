// Created for Galleon in 2021
// Using Swift 5.0

import Foundation

// MARK: - SonarrHistory
public struct SonarrHistory: Codable {
    var page, pageSize: Int?
    var sortKey, sortDirection: String?
    var totalRecords: Int?
    var records: [SonarrHistoryRecord]?
}

// MARK: - SonarrHistory
public struct SonarrHistoryRecord: Codable, Hashable {
    var episodeID, seriesID: Int?
    var sourceTitle: String?
    var quality: SonarrHistoryQuality?
    var qualityCutoffNotMet: Bool?
    var date, eventType: String?
    var data: SonarrData?
    var episode: SonarrEpisode?
    var series: SonarrSeries?
    var id: Int?

    enum CodingKeys: String, CodingKey {
        case episodeID = "episodeId"
        case seriesID = "seriesId"
        case sourceTitle, quality, qualityCutoffNotMet, date, eventType, data, episode, series, id
    }
    
    public static func == (lhs: SonarrHistoryRecord, rhs: SonarrHistoryRecord) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - SonarrData
public struct SonarrData: Codable, Hashable {
    var reason: String?
    
    public static func == (lhs: SonarrData, rhs: SonarrData) -> Bool {
        lhs.reason == rhs.reason
    }
}

// MARK: - SonarrEpisode
public struct SonarrEpisode: Codable, Hashable {
    var seriesID, episodeFileID, seasonNumber, episodeNumber: Int?
    var title, airDate, airDateUTC, overview: String?
    var hasFile, monitored: Bool?
    var absoluteEpisodeNumber: Int?
    var unverifiedSceneNumbering: Bool?
    var id: Int?

    enum CodingKeys: String, CodingKey {
        case seriesID = "seriesId"
        case episodeFileID = "episodeFileId"
        case seasonNumber, episodeNumber, title, airDate
        case airDateUTC = "airDateUtc"
        case overview, hasFile, monitored, absoluteEpisodeNumber, unverifiedSceneNumbering, id
    }
    
    public static func == (lhs: SonarrEpisode, rhs: SonarrEpisode) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - SonarrHistoryQuality
public struct SonarrHistoryQuality: Codable, Hashable {
    var quality: SonarrQualityQuality?
    var revision: SonarrRevision?
    
    public static func == (lhs: SonarrHistoryQuality, rhs: SonarrHistoryQuality) -> Bool {
        lhs.quality == rhs.quality && lhs.revision == rhs.revision
    }
}

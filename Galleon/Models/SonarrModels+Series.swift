// Created for Galleon in 2021
// Using Swift 5.0

import Foundation

// MARK: - SonarrSeries
public struct SonarrSeries: Codable, Hashable {
    public static func == (lhs: SonarrSeries, rhs: SonarrSeries) -> Bool {
        lhs.id == rhs.id
    }
    
    var title: String?
    var alternateTitles: [SonarrAlternateTitle]?
    var sortTitle: String?
    var seasonCount, totalEpisodeCount, episodeCount, episodeFileCount: Int?
    var sizeOnDisk: Int?
    var status, overview, previousAiring, network: String?
    var airTime: String?
    var images: [SonarrImage]?
    var seasons: [SonarrSeason]?
    var year: Int?
    var path: String?
    var profileID, languageProfileID: Int?
    var seasonFolder, monitored, useSceneNumbering: Bool?
    var runtime, tvdbID, tvRageID, tvMazeID: Int?
    var firstAired, lastInfoSync, seriesType, cleanTitle: String?
    var imdbID, titleSlug, certification: String?
    var genres: [String]?
    var tags: [Int]?
    var added: String?
    var ratings: SonarrRatings?
    var qualityProfileID, id: Int?

    enum CodingKeys: String, CodingKey {
        case title, alternateTitles, sortTitle, seasonCount, totalEpisodeCount, episodeCount, episodeFileCount, sizeOnDisk, status, overview, previousAiring, network, airTime, images, seasons, year, path
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

//public struct SonarrSeries: Codable, Hashable {
//    var title, sortTitle: String?
//    var seasonCount: Int?
//    var status, overview, network, airTime: String?
//    var images: [SonarrImage]?
//    var seasons: [SonarrSeason]?
//    var year: Int?
//    var path: String?
//    var profileID, languageProfileID: Int?
//    var seasonFolder, monitored, useSceneNumbering: Bool?
//    var runtime, tvdbID, tvRageID, tvMazeID: Int?
//    var firstAired, lastInfoSync, seriesType, cleanTitle: String?
//    var imdbID, titleSlug, certification: String?
//    var genres: [String]?
//    var tags: [Int]?
//    var added: String?
//    var ratings: SonarrRatings?
//    var qualityProfileID, id: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case title, sortTitle, seasonCount, status, overview, network, airTime, images, seasons, year, path
//        case profileID = "profileId"
//        case languageProfileID = "languageProfileId"
//        case seasonFolder, monitored, useSceneNumbering, runtime
//        case tvdbID = "tvdbId"
//        case tvRageID = "tvRageId"
//        case tvMazeID = "tvMazeId"
//        case firstAired, lastInfoSync, seriesType, cleanTitle
//        case imdbID = "imdbId"
//        case titleSlug, certification, genres, tags, added, ratings
//        case qualityProfileID = "qualityProfileId"
//        case id
//    }
//}

// MARK: - SonarrAlternateTitle
struct SonarrAlternateTitle: Codable, Hashable {
    var title: String?
    var sceneSeasonNumber: Int?
}

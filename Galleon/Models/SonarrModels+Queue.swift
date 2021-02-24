// Created for Galleon in 2021
// Using Swift 5.0

import Foundation

// MARK: - SonarrQueueElement
public struct SonarrQueueEntry: Codable, Hashable, Identifiable {
    var series: SonarrEpisodeSeries?
    var episode: SonarrEpisode?
    var quality: SonarrQuality?
    var size: Int?
    var title: String?
    var sizeleft: Int?
    var timeleft, estimatedCompletionTime, status, trackedDownloadStatus: String?
    var statusMessages: [SonarrStatusMessage]?
    var downloadID, queueProtocol: String?
    public var id: Int?

    enum CodingKeys: String, CodingKey {
        case series, episode, quality, size, title, sizeleft, timeleft, estimatedCompletionTime, status, trackedDownloadStatus, statusMessages
        case downloadID = "downloadId"
        case queueProtocol = "protocol"
        case id
    }
    
    public static func == (lhs: SonarrQueueEntry, rhs: SonarrQueueEntry) -> Bool {
        return lhs.id == rhs.id && lhs.sizeleft == rhs.sizeleft && lhs.timeleft == rhs.timeleft
    }
}

// MARK: - SonarrStatusMessage
struct SonarrStatusMessage: Codable, Hashable {
    var title: String?
    var messages: [String]?
}

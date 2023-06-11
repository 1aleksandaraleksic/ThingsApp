//
//  EpisodeResponse.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 6.6.23..
//

import Foundation

// MARK: - EpisodesResponse
struct EpisodesResponse: Codable {
    let info: Info?
    var results: [Result]?
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int?
    let next: String?
    let prev: String?
}

// MARK: - Result
class Result: Codable, Equatable {
    static func == (lhs: Result, rhs: Result) -> Bool {
        return lhs.id == rhs.id
    }

    let id: Int?
    let name, airDate, episode: String?
    let characters: [String]?
    let url: String?
    let created: String?
    var comment: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created, comment
    }
}

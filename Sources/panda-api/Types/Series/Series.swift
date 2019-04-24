//
//  Series.swift
//  panda-api
//
//  Created by Mason Phillips on 4/21/19.
//

import Foundation

public struct Serie: Decodable {
    public let begin_at: Date?
    public let description: String?
    public let end_at: Date?
    public let full_name: String
    public let id: Int
    public let league: BaseLeague
    public let league_id: Int
    public let modified_at: Date?
    public let name: String?
    public let prizepool: String?
    public let season: String?
    public let slug: String
    public let tournaments: [BaseTournament]
    public let videogame: Videogame
    public let winner_id: Int?
    public let winner_type: OpponentType?
    public let year: Int
}

public struct BaseSerie: Decodable {
    public let begin_at: Date?
    public let description: String?
    public let end_at: String?
    public let full_name: String
    public let id: Int
    public let league_id: Int
    public let modified_at: Date?
    public let name: String?
    public let prizepool: String?
    public let season: String?
    public let slug: String
    public let winner_id: Int?
    public let winner_type: OpponentType?
    public let year: Int
}

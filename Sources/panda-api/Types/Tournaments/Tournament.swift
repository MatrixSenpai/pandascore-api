//
//  Tournament.swift
//  panda-api
//
//  Created by Mason Phillips on 4/21/19.
//

import Foundation

public struct Tournament: Decodable {
    public let begin_at: Date?
    public let end_at: Date?
    public let id: Int
    public let league: BaseLeague
    public let league_id: Int
    public let matches: [BaseMatch]
    public let modified_at: Date?
    public let name: String
    public let serie: BaseSerie
    public let slug: String
    public let teams: [BaseTeam]
    public let videogame: Videogame
    public let winner_id: Int?
    public let winner: OpponentType?
}

public struct BaseTournament: Decodable {
    public let begin_at: Date?
    public let end_at: Date?
    public let id: Int
    public let league_id: Int
    public let modified_at: Date?
    public let name: String
    public let serie_id: Int
    public let slug: String
    public let winner_id: Int?
    public let winner_type: OpponentType?
}

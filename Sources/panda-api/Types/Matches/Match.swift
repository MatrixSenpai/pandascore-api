//
//  Match.swift
//  panda-api
//
//  Created by Mason Phillips on 4/21/19.
//

import Foundation

public struct Match: Decodable {
    public let begin_at: Date?
    public let draw: Bool
    public let games: [BaseGame]
    public let id: Int
    public let league: BaseLeague
    public let league_id: Int
    public let live: MatchLive
    public let match_type: MatchType
    public let modified_at: Date?
    public let name: String
    public let number_of_games: Int?
    public let opponents: [Opponent]
    public let results: [MatchTeamResult]
    public let serie: BaseSerie
    public let serie_id: Int
    public let slug: String?
    public let status: MatchStatus
    public let tournament: BaseTournament
    public let tournament_id: Int
    public let videogame: Videogame
    public let winner: Winner?
    public let winner_id: Int?
}

public struct BaseMatch: Decodable {
    public let begin_at: Date?
    public let draw: Bool
    public let id: Int
    public let live: MatchLive
    public let match_type: MatchType?
    public let modified_at: Date?
    public let name: String
    public let number_of_games: Int?
    public let slug: String?
    public let status: MatchStatus
    public let tournament_id: Int
    public let winner_id: Int?
}

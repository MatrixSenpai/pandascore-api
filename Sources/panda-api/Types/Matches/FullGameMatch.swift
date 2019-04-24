//
//  FullGameMatch.swift
//  panda-api
//
//  Created by Mason Phillips on 4/21/19.
//

import Foundation

public struct FullGameMatch: Decodable {
    public let begin_at: Date?
    public let draw: Bool
    public let games: [BaseGame]
    public let id: Int
    public let league: BaseLeague
    public let league_id: Int
    public let live: MatchLive
    public let match_type: MatchType?
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
    public let videogame_version: ShortVideogameVersion
    public let winner: BaseTeam
    public let winner_id: Int
}

public struct MatchLive: Decodable {
    public let opens_at: Date?
    public let supported: Bool
    public let url: URL?
}

public enum MatchType: String, Decodable {
    case best_of, custom, ow_best_of
}

public struct MatchTeamResult: Decodable {
    public let score: Int
    public let team_id: Int
}

public enum MatchStatus: String, Decodable {
    case not_started, running, finished
}

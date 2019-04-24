//
//  StatsObject.swift
//  panda-api
//
//  Created by Mason Phillips on 4/21/19.
//

import Foundation

public struct StatsPlayer: Decodable {
    public let current_team: BaseTeam?
    public let current_videogame: Videogame?
    public let favorite_champions: [FavoriteChampion]
    public let first_name: String?
    public let hometown: String?
    public let id: Int
    public let image_url: URL?
    public let last_games: [GamePlayer]
    public let last_name: String?
    public let name: String
    public let role: Role?
    public let slug: String?
    public let stats: [PlayerBySerieStats]
    public let teams: [BaseTeam]
}

public struct StatsTeam: Decodable {
    public let acronym: String?
    public let id: Int
    public let image_url: URL?
    public let last_games: [TeamLastGame]
    public let most_picked: [MostPickedOrBanned]
    public let most_banned: [MostPickedOrBanned]
    public let name: String
    public let players: [BasePlayer]
    public let stats: [TeamBySerieStat]
}

public struct FavoriteChampion: Decodable {
    public let champion: Champion
    public let games_count: Int
    public let most_used_items: [UsedItem]
}

public struct UsedItem: Decodable {
    public let count: Int
    public let id: Int
    public let name: String
}

public struct PlayerBySerieStats: Decodable {
    public let averages: PlayerAverage
    public let games_count: Int
    public let serie: Serie
    public let totals: StatsTotal
}

public struct PlayerAverage: Decodable {
    public let assists: Float?
    public let deaths: Float?
    public let kills: Float?
    public let minions_killed: Float?
    public let wards_placed: Float?
}

public struct StatsTotal: Decodable {
    public let games_lost: Int?
    public let games_played: Int?
    public let games_won: Int?
    public let matches_lost: Int?
    public let matches_played: Int?
    public let matches_won: Int?
}

public struct TeamLastGame: Decodable {
    public let begin_at: Date?
    public let finished: Bool?
    public let id: Int
    public let length: Int?
    public let match_id: Int
    public let players: [GamePlayer]
    public let position: Int
    public let teams: [GameTeam]
    public let winner: Winner
    public let winner_type: OpponentType?
}

public struct MostPickedOrBanned: Decodable {
    public let count: Int
    public let name: String
}

public struct TeamBySerieStat: Decodable {
    public let averages: TeamAverage
    public let games_count: Int?
    public let serie: Serie
    public let totals: StatsTotal
}

public struct TeamAverage: Decodable {
    public let assists: Float?
    public let baron_kills: Float?
    public let deaths: Float?
    public let dragon_kills: Float?
    public let gold_earned: Float?
    public let herald_kill: Float?
    public let inhibitor_kills: Float?
    public let kills: Float?
    public let ratios: TeamRatio
    public let total_minions_killed: Float?
    public let tower_kills: Float?
    public let wards_placed: Float?
}

public struct TeamRatio: Decodable {
    public let first_baron: Float?
    public let first_blood: Float?
    public let first_dragon: Float?
    public let first_inhibitor: Float?
    public let first_tower: Float?
    public let win: Float?
}

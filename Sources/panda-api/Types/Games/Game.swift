//
//  Game.swift
//  panda-api
//
//  Created by Mason Phillips on 4/21/19.
//

import Foundation

/// A League of Legends Game
public struct Game: Decodable {
    // Info
    /// Game ID
    public let id: Int
    /// Game position in a series of games
    public let position: Int
    /// The start of the match
    public let begin: Date?
    /// Game has ended
    public let finished: Bool?
    /// Game length (seconds)
    public let length: Int?

    // Participants
    /// Array of players
    public let players: [GamePlayer]
    /// The participating teams
    public let teams: [GameTeam]

    // Reference
    /// Full match reference
    public let match: FullGameMatch
    /// Match reference ID
    public let matchID: Int
    /// Winner object, with reference to the team ID
    public let winner: Winner
    /// The type (player/team)
    public let winnerType: OpponentType?
    
    enum CodingKeys: String, CodingKey {
        case id, position, finished, length, players, teams, match, winner
        case begin = "begin_at"
        case matchID = "match_id"
        case winnerType = "winner_type"
    }
}

/// A simplified Game object
public struct BaseGame: Decodable {
    // Info
    /// Game ID
    public let id: Int
    /// Game position in a series of games
    public let position: Int
    /// The start of the match
    public let begin: Date?
    /// Game has ended
    public let finished: Bool?
    /// Game length (seconds)
    public let length: Int?
    
    // Reference
    /// Match reference ID
    public let matchID: Int
    /// Winner object, with reference to the team ID
    public let winner: Winner
    /// The type (player/team)
    public let winnerType: OpponentType?
    
    enum CodingKeys: String, CodingKey {
        case id, position, finished, length, winner
        case begin = "begin_at"
        case matchID = "match_id"
        case winnerType = "winner_type"
    }
}

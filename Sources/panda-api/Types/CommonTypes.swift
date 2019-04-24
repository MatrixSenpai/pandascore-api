//
//  CommonTypes.swift
//  panda-api
//
//  Created by Mason Phillips on 4/21/19.
//

import Foundation

public enum Timing: String {
    case all, past, running, upcoming
}

public enum GroupingType: String {
    case all, tournament, serie
}

public enum StatsType: String {
    case team, player
}

/// Either "Team" or "Player"
public enum OpponentType: String, Decodable {
    case Team, Player
}

/// An opponent

public protocol BaseOpponent {}
public struct Opponent: Decodable {
    public let type: OpponentType
    public let opponent: BaseOpponent
    
    enum CodingKeys: String, CodingKey {
        case type, opponent
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(OpponentType.self, forKey: .type)
        switch type {
        case .Player: opponent = try container.decode(BasePlayer.self, forKey: .opponent)
        case .Team  : opponent = try container.decode(BaseTeam.self, forKey: .opponent)
        }
    }
}

public struct Winner: Decodable {
    public let id: Int?
    public let type: OpponentType?
}

public enum TeamColor: String, Decodable {
    case blue, red
}

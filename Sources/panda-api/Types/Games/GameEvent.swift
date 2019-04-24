//
//  GameEvent.swift
//  panda-api
//
//  Created by Mason Phillips on 4/22/19.
//

import Foundation

public struct GameEvent: Decodable {
    public let game_id: Int
    public let ingame_timestamp: Int
    public let is_first: Bool
    public let match_id: Int
    public let payload: EventPayload
    public let tournament_id: Int
    public let type: EventType
}

public struct GameFrame: Decodable {
    public let blue: FrameTeam
    public let current_timestamp: Int
    public let game_id: Int
    public let match_id: Int
    public let red: FrameTeam
    public let tournament_id: Int
}

public struct EventPayload: Decodable {
    public let assists: [EventAssist]
    public let killer: EventKiller
    public let victim: EventVictim
}

public struct EventAssist: Decodable {
    public let champion: EventChampion
    public let player_id: Int
    public let player_name: String
    public let side: TeamColor
}

public protocol EventKillerObjectType {}
public struct EventKiller: Decodable {
    public let object: EventKillerObjectType?
    public let type: EventKillerType
    
    enum CodingKeys: String, CodingKey {
        case object, type
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(EventKillerType.self, forKey: .type)
        switch type {
        case .drake: object = try container.decodeIfPresent(EventDrake.self, forKey: .object)
        case .herald: object = try container.decodeIfPresent(EventHerald.self, forKey: .object)
        case .minion: object = try container.decodeIfPresent(EventMinion.self, forKey: .object)
        case .baron_nashor: object = try container.decodeIfPresent(EventNashor.self, forKey: .object)
        case .player: object = try container.decodeIfPresent(EventPlayer.self, forKey: .object)
        case .tower: object = try container.decodeIfPresent(EventTower.self, forKey: .object)
        case .neutral_minion: object = try container.decodeIfPresent(EventNeutralMinion.self, forKey: .object)
        default: object = nil
        }
    }
}

public struct EventDrake: Decodable, EventKillerObjectType, EventVictimObjectType {
    public let name: DrakeName
    public let type: DrakeType
}

public enum DrakeName: String, Decodable {
    case cloud = "Cloud Drake"
    case elder = "Elder Drake"
    case infernal = "Infernal Drake"
    case mountain = "Mountain Drake"
    case ocean = "Ocean Drake"
}
public enum DrakeType: String, Decodable {
    case cloud, elder, infernal, mountain, ocean
}

public struct EventHerald: Decodable, EventKillerObjectType {
    public let name: String
}

public struct EventMinion: Decodable, EventKillerObjectType {
    public let name: String
    public let side: TeamColor
}

public struct EventNashor: Decodable, EventKillerObjectType, EventVictimObjectType {
    public let name: String
}

public struct EventTower: Decodable, EventKillerObjectType, EventVictimObjectType {
    public let name: String
    public let side: TeamColor
}

public struct EventNeutralMinion: Decodable, EventKillerObjectType {
    public let name: EventMinionName
}
public enum EventMinionName: String, Decodable {
    case corbin = "Big Corbin"
    case golem  = "Big Golem"
    case wolf   = "Big Wolf"
    case blue   = "Blue Buff"
    case gromp  = "Gromp"
    case red    = "Red Buff"
    case smallcorbin = "Small Corbin"
    case smallgolem = "Small Golem"
    case smallwolf = "Small Wolf"
}

public enum EventKillerType: String, Decodable {
    case baron_nashor, drake, herald, minion, neutral_minion, player, tower, unknown
}

public protocol EventVictimObjectType {}
public struct EventVictim: Decodable {
    public let object: EventVictimObjectType
    public let type: EventVictimType
    
    enum CodingKeys: String, CodingKey {
        case object, type
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(EventVictimType.self, forKey: .type)
        switch type {
        case .baron_nashor: object = try container.decode(EventNashor.self, forKey: .object)
        case .drake: object = try container.decode(EventDrake.self, forKey: .object)
        case .player: object = try container.decode(EventPlayer.self, forKey: .object)
        case .tower: object = try container.decode(EventTower.self, forKey: .object)
        case .inhibitor: object = try container.decode(EventInhibitor.self, forKey: .object)
        }
    }
}

public struct EventInhibitor: Decodable, EventVictimObjectType {
    public let name: String
    public let side: TeamColor
}

public enum EventVictimType: String, Decodable {
    case baron_nashor, drake, inhibitor, player, tower
}

public enum EventType: String, Decodable {
    case baron_nashor_kill, drake_kill, inhibitor_kill, player_kill, suicide, tower_kill
}

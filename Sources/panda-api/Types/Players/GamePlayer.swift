//
//  GamePlayer.swift
//  panda-api
//
//  Created by Mason Phillips on 4/21/19.
//

import Foundation

public struct GamePlayer: Decodable {
    public let assists: Int?
    public let champion: BaseChampion
    public let deaths: Int?
    public let flags: Flag
    public let game_id: Int
    public let gold_earned: Int?
    public let gold_spent: Int?
    public let items: [BaseItem]
    public let kills: Int?
    public let kills_counters: KillsCounters
    public let kills_series: KillsSeries
    public let largest_critical_strike: Int?
    public let largest_killing_spree: Int?
    public let largest_multi_kill: Int?
    public let level: Int?
    public let magic_damage: MagicDamage
    public let masteries: [Mastery]
    public let minions_killed: Int?
    public let opponent: BaseTeam?
    public let physical_damage: PhysicalDamage
    public let player: BasePlayer
    public let player_id: Int
    public let role: Role?
    public let runes: [Rune]
    public let spells: [Spell]
    public let team: BaseTeam
    public let total_damage: TotalDamage
    public let total_heal: Int?
    public let total_time_crowd_control_dealt: Int?
    public let total_units_healed: Int?
    public let true_damage: TrueDamage
    public let wards: Ward
    public let wards_placed: Int?
}

public struct Flag: Decodable {
    let first_blood_assist: Bool?
    let first_blood_kill: Bool?
    let first_inhibitor_assist: Bool?
    let first_inhibitor_kill: Bool?
    let first_tower_assist: Bool?
    let first_tower_kill: Bool?
}

public struct KillsCounters: Decodable {
    public let inhibitors: Int?
    public let neutral_minions: Int?
    public let neutral_minions_enemy_jungle: Int?
    public let neutral_minions_team_jungle: Int?
    public let players: Int?
    public let turrets: Int?
    public let wards: Int?
}

public struct KillsSeries: Decodable {
    public let double_kills: Int?
    public let triple_kills: Int?
    public let quadra_kills: Int?
    public let penta_kills: Int?
}

public struct MagicDamage: Decodable {
    public let dealt: Int?
    public let dealt_to_champions: Int?
}

public struct PhysicalDamage: Codable {
    public let dealt: Int?
    public let dealt_to_champions: Int?
    public let taken: Int?
}

public enum Role: String, Codable, Equatable {
    case adc, jun, mid, sup, top
    
    private var sortOrder: Int {
        switch self {
        case .top: return 1
        case .jun: return 2
        case .mid: return 3
        case .adc: return 4
        case .sup: return 5
        }
    }
    public static func <(l: Role, r: Role) -> Bool {
        return l.sortOrder < r.sortOrder
    }
    public static func >(l: Role, r: Role) -> Bool {
        return l.sortOrder > r.sortOrder
    }
    public static func ==(l: Role, r: Role) -> Bool {
        return l.sortOrder == r.sortOrder
    }
}

public struct TotalDamage: Codable {
    public let dealt: Int?
    public let dealt_to_champions: Int?
    public let taken: Int?
}

public struct TrueDamage: Codable {
    public let dealt: Int?
    public let dealt_to_champions: Int?
    public let taken: Int?
}

public struct Ward: Codable {
    public let placed: Int?
    public let sight_wards_bought_in_game: Int?
    public let vision_wards_bought_in_game: Int?
}

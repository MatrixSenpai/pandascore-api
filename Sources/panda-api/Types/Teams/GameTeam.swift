//
//  GameTeam.swift
//  panda-api
//
//  Created by Mason Phillips on 4/21/19.
//

import Foundation

public struct GameTeam: Decodable {
    public let bans: [Int]
    public let baron_kills: Int?
    public let color: TeamColor
    public let dragon_kills: Int?
    public let first_blood: Bool?
    public let first_dragon: Bool?
    public let first_inhibitor: Bool?
    public let first_tower: Bool?
    public let gold_earned: Int?
    public let inhibitor_kills: Int?
    public let player_ids: [Int]
    public let team: BaseTeam
    public let tower_kills: Int?
}

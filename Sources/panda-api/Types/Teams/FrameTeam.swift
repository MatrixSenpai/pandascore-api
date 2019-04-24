//
//  FrameTeam.swift
//  panda-api
//
//  Created by Mason Phillips on 4/22/19.
//

import Foundation

public struct FrameTeam: Decodable {
    public let acronym: String
    public let drakes: Int
    public let gold: Int
    public let id: Int
    public let inhibitors: Int
    public let kills: Int
    public let name: String
    public let nashors: Int
    public let players: PlayerRoles
    public let score: Int
    public let towers: Int
}

public struct PlayerRoles: Decodable {
    public let adc: PlayerRoleDetail
    public let jun: PlayerRoleDetail
    public let mid: PlayerRoleDetail
    public let sup: PlayerRoleDetail
    public let top: PlayerRoleDetail
}

public struct PlayerRoleDetail: Decodable {
    public let assists: Int
    public let champion: BaseChampion
    public let cs: Int
    public let deaths: Int
    public let id: Int
    public let kills: Int
    public let level: Int
    public let name: String
    public let summoner_spells: [Spell]
}

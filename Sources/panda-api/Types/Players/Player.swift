//
//  Player.swift
//  panda-api
//
//  Created by Mason Phillips on 4/21/19.
//

import Foundation

public struct Player: Decodable {
    public let current_team: BaseTeam?
    public let current_videogame: Videogame?
    public let first_name: String?
    public let hometown: String?
    public let id: Int
    public let image_url: URL?
    public let last_name: String?
    public let name: String
    public let role: Role?
    public let slug: String?
}

public struct BasePlayer: Decodable, BaseOpponent {
    public let first_name: String?
    public let hometown: String?
    public let id: Int
    public let image_url: URL?
    public let last_name: String?
    public let name: String
    public let role: Role?
    public let slug: String?
}

public struct EventPlayer: Decodable, EventKillerObjectType, EventVictimObjectType {
    public let champion: EventChampion
    public let player_id: Int
    public let player_name: String
    public let side: TeamColor
}

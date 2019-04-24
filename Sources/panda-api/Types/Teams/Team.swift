//
//  Team.swift
//  panda-api
//
//  Created by Mason Phillips on 4/21/19.
//

import Foundation

public struct Team: Decodable {
    public let acronym: String?
    public let current_videogame: Videogame?
    public let id: Int
    public let image_url: URL?
    public let name: String
    public let players: [BasePlayer]
    public let slug: String?
}

public struct BaseTeam: Decodable, BaseOpponent {
    public let acronym: String?
    public let id: Int
    public let image_url: URL?
    public let name: String
    public let slug: String
}

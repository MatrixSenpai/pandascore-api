//
//  Videogame.swift
//  panda-api
//
//  Created by Mason Phillips on 4/21/19.
//

import Foundation

public struct Videogame: Decodable {
    public let current_version: String?
    public let id: Int
    public let name: String
    public let slug: String
}

public struct ShortVideogameVersion: Decodable {
    public let current: Bool
    public let name: String
}

//
//  Spell.swift
//  panda-api
//
//  Created by Mason Phillips on 4/21/19.
//

import Foundation

public struct Spell: Codable {
    public let id: Int
    public let image_url: URL
    public let name: String
}

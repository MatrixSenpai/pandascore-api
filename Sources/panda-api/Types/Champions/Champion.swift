//
//  Champion.swift
//  panda-api
//
//  Created by Mason Phillips on 4/21/19.
//

import Foundation

/// A League of Legends Champion
public class Champion: Decodable {
    // Info
    /// ID of champion
    public let id: Float
    /// Champion name
    public let name: String
    /// Splash Art
    public let splashArt: URL
    /// Icon
    public let icon: URL
    /// Patches where this champion is available
    public let availableIn: [String]

    // Stats
    /// Movement Speed
    public let movementSpeed: Float
    /// Attack Damage
    public let attackdamage: Float
    /// Attack Damage gained per level
    public let attackdamageperlevel: Float
    /// Attack Range
    public let attackrange: Float
    /// Attack Speed offset
    public let attackspeedoffset: Float?
    /// Attack Speed gained per level
    public let attackspeedperlevel: Float
    /// Critical Chance
    public let crit: Float
    /// Critical Chance gained per level
    public let critperlevel: Float

    // Health & Mana
    /// Base hitpoints (health)
    public let hp: Float
    /// Hitpoints gained per level
    public let hpperlevel: Float
    /// Hitpoints regen
    public let hpregen: Float
    /// Hitpoints regen gained per level
    public let hpregenperlevel: Float
    /// Mana pool
    public let mp: Float
    /// Mana pool gained per level
    public let mpperlevel: Float
    /// Mana pool regen
    public let mpregen: Float
    /// Mana pool regen per level
    public let mpregenperlevel: Float

    // Resistance
    /// Armor
    public let armor: Float
    /// Armor gained per level
    public let armorperlevel: Float
    /// Magic resistance
    public let magicresist: Float
    /// Magic resistance gained per level
    public let magicresistperlevel: Float

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringCodingKey.self)
        armor = try container.decode("armor")
        armorperlevel = try container.decode("armorperlevel")
        attackdamage = try container.decode("attackdamage")
        attackdamageperlevel = try container.decode("attackdamageperlevel")
        attackrange = try container.decode("attackrange")
        attackspeedoffset = try container.decode("attackspeedoffset")
        attackspeedperlevel = try container.decode("attackspeedperlevel")
        splashArt = try container.decode("big_image_url")
        crit = try container.decode("crit")
        critperlevel = try container.decode("critperlevel")
        hp = try container.decode("hp")
        hpperlevel = try container.decode("hpperlevel")
        hpregen = try container.decode("hpregen")
        hpregenperlevel = try container.decode("hpregenperlevel")
        id = try container.decode("id")
        icon = try container.decode("image_url")
        movementSpeed = try container.decode("movespeed")
        mp = try container.decode("mp")
        mpperlevel = try container.decode("mpperlevel")
        mpregen = try container.decode("mpregen")
        mpregenperlevel = try container.decode("mpregenperlevel")
        name = try container.decode("name")
        magicresist = try container.decode("spellblock")
        magicresistperlevel = try container.decode("spellblockperlevel")
        availableIn = try container.decode("videogame_versions")

    }
}

/// A simple version of Champion
public struct BaseChampion: Decodable {
    /// The ID of the champion
    public let id: Int
    /// The icon of the champion
    public let icon: URL
    /// The name of the champion
    public let name: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case icon = "image_url"
    }
}

/// A simplified version of Champion for Events
public struct EventChampion: Decodable {
    /// The ID of the champion
    public let id: Int
    /// The name of the champion
    public let name: String
}

//
//  Item.swift
//  panda-api
//
//  Created by Mason Phillips on 4/21/19.
//

import Foundation

public struct Item: Decodable {
    public let flat_armor_mod: Int?
    public let flat_crit_change_mod: Int?
    public let flat_hp_pool_mod: Int?
    public let flat_hp_regen_mod: Int?
    public let flat_magic_damage_mod: Int?
    public let flat_movement_speed_mod: Int?
    public let flat_mp_pool_mod: Int?
    public let flat_mp_regen_mod: Int?
    public let flat_physical_damage_mod: Int?
    public let flat_spell_block_mod: Int?
    public let gold_base: Int?
    public let gold_purchasable: Bool?
    public let gold_sell: Int?
    public let gold_total: Int?
    public let id: Int
    public let image_url: URL?
    public let is_trinket: Bool?
    public let name: String
    public let percent_attack_speed_mod: Int?
    public let percent_life_steal_mod: Int?
    public let percent_movement_speed_mod: Int?
    public let videogame_versions: [String]
}

public struct BaseItem: Decodable {
    public let id: Int
    public let image_url: URL?
    public let is_trinket: Bool?
    public let name: String
}

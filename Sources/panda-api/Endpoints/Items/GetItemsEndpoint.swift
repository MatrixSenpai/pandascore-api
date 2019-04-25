//
//  GetItemsEndpoint.swift
//  panda-api
//
//  Created by Mason Phillips on 4/24/19.
//

import Foundation
import RxSwift

struct GetItemsEndpoint: APIRequest {
    typealias Response = [Item]
    typealias Option = GetItemsOptions
    var base: String { return "lol/items" }
    var endpoint: String { return base }
    var options: Option?
    
    init(page: Int?, per_page: Int?, range: ItemsParameterObject?, filter: ItemsParameterObject?, sort: ItemsSortObject?) {
        options = GetItemsOptions(page: page, per_page: per_page, range: range, filter: filter, sort: sort)
    }
    
    struct GetItemsOptions: Options {
        typealias RangeObject = ItemsParameterObject
        typealias FilterObject = ItemsParameterObject
        typealias SortObject = ItemsSortObject
        var page: Int?
        var per_page: Int?
        var range: RangeObject?
        var filter: FilterObject?
        var sort: SortObject?
    }
}

public struct ItemsParameterObject: ParameterObject {
    public let flat_armor_mod: [Int]?
    public let flat_crit_chance_mod: [Int]?
    public let flat_hp_pool_mod: [Int]?
    public let flat_hp_regen_mod: [Int]?
    public let flat_magic_damage_mod: [Int]?
    public let flat_movement_speed_mod: [Int]?
    public let flat_mp_pool_mod: [Int]?
    public let flat_mp_regen_mod: [Int]?
    public let flat_physical_damage_mod: [Int]?
    public let flat_spell_block_mod: [Int]?
    public let gold_base: [Int]?
    public let gold_purchasable: [Bool]?
    public let gold_sell: [Int]?
    public let gold_total: [Int]?
    public let id: [Int]?
    public let is_trinket: [Bool]?
    public let name: [String]?
    public let percent_attack_speed_mod: [Int]?
    public let percent_life_steal_mod: [Int]?
    public let percent_movement_speed_mod: [Int]?
    
    public init(flat_armor_mod: [Int]? = nil, flat_crit_chance_mod: [Int]? = nil, flat_hp_pool_mod: [Int]? = nil, flat_hp_regen_mod: [Int]? = nil, flat_magic_damage_mod: [Int]? = nil, flat_movement_speed_mod: [Int]? = nil, flat_mp_pool_mod: [Int]? = nil, flat_mp_regen_mod: [Int]? = nil, flat_physical_damage_mod: [Int]? = nil, flat_spell_block_mod: [Int]? = nil, gold_base: [Int]? = nil, gold_purchasable: [Bool]? = nil, gold_sell: [Int]? = nil, gold_total: [Int]? = nil, id: [Int]? = nil, is_trinket: [Bool]? = nil, name: [String]? = nil, percent_attack_speed_mod: [Int]? = nil, percent_life_steal_mod: [Int]? = nil, percent_movement_speed_mod: [Int]? = nil) {
        self.flat_armor_mod = flat_armor_mod
        self.flat_crit_chance_mod = flat_crit_chance_mod
        self.flat_hp_pool_mod = flat_hp_pool_mod
        self.flat_hp_regen_mod = flat_hp_regen_mod
        self.flat_magic_damage_mod = flat_magic_damage_mod
        self.flat_movement_speed_mod = flat_movement_speed_mod
        self.flat_mp_pool_mod = flat_mp_pool_mod
        self.flat_mp_regen_mod = flat_mp_regen_mod
        self.flat_physical_damage_mod = flat_physical_damage_mod
        self.flat_spell_block_mod = flat_spell_block_mod
        self.gold_base = gold_base
        self.gold_purchasable = gold_purchasable
        self.gold_sell = gold_sell
        self.gold_total = gold_total
        self.id = id
        self.is_trinket = is_trinket
        self.name = name
        self.percent_attack_speed_mod = percent_attack_speed_mod
        self.percent_life_steal_mod = percent_life_steal_mod
        self.percent_movement_speed_mod = percent_movement_speed_mod
    }
}

public struct ItemsSortObject: SortObject {
    typealias KeyType = ItemsSortKey
    var keys: [(ItemsSortKey, Bool)]?
    
    public enum ItemsSortKey: String {
        case flat_armor_mod, flat_crit_chance_mod, flat_hp_pool_mod, flat_hp_regen_mod, flat_magic_damage_mod, flat_movement_speed_mod, flat_mp_pool_mod, flat_mp_regen_mod,
        flat_physical_damage_mod, flat_spell_block_mod, gold_base, gold_purchasable, gold_sell, gold_total, id, is_trinket, name, percent_attack_speed_mod, percent_life_steal_mod,
        percent_movement_speed_mod
    }
    
    public init(_ keys: [(ItemsSortKey, Bool)]) {
        self.keys = keys
    }
}

public extension Client {
    func getItems(page: Int? = nil, per_page: Int? = nil, range: ItemsParameterObject? = nil, filter: ItemsParameterObject? = nil, sort: ItemsSortObject? = nil, completion: @escaping APIResponse<[Item]>) {
        return send(GetItemsEndpoint(page: page, per_page: per_page, range: range, filter: filter, sort: sort), completion: completion)
    }
    func getItems(page: Int? = nil, per_page: Int? = nil, range: ItemsParameterObject? = nil, filter: ItemsParameterObject? = nil, sort: ItemsSortObject? = nil) -> Single<[Item]> {
        return send(GetItemsEndpoint(page: page, per_page: per_page, range: range, filter: filter, sort: sort))
    }
}

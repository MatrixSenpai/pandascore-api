//
//  GetPlayersForSeriesEndpoint.swift
//  panda-api
//
//  Created by Mason Phillips on 4/24/19.
//

import Foundation
import RxSwift

struct GetPlayersForEndpoint: APIRequest {
    typealias Response = [Player]
    typealias Option = GetPlayerOptions
    var base: String { return "lol" }
    var endpoint: String {
        switch type {
        case .all: return base + "/players"
        default:
            guard let id = id else { fatalError("Must specify ID with any case that is not `all`")}
            return base + "/\(type.rawValue)s/\(id)/players"
        }
    }
    var options: Option?
    var id: Int?
    var type: GroupingType
    
    init(type: GroupingType, id: Int?, page: Int?, per_page: Int?, filter: PlayerParameterObject?, range: PlayerParameterObject?, sort: PlayerSortObject?) {
        self.type = type
        self.id = id
        self.options = GetPlayerOptions(page: page, per_page: per_page, range: range, filter: filter, sort: sort)
    }
    
    struct GetPlayerOptions: Options {
        typealias RangeObject = PlayerParameterObject
        typealias FilterObject = PlayerParameterObject
        typealias SortObject = PlayerSortObject
        var page: Int?
        var per_page: Int?
        var range: RangeObject?
        var filter: FilterObject?
        var sort: SortObject?
    }
}

public struct PlayerParameterObject: ParameterObject {
    public let first_name: [String]?
    public let hometown: [String]?
    public let id: [Int]?
    public let last_name: [String]?
    public let name: [String]?
    public let role: [String]?
    public let slug: [String]?
    
    init(first_name: [String]? = nil, hometown: [String]? = nil, id: [Int]? = nil, last_name: [String]? = nil, name: [String]? = nil, role: [String]? = nil, slug: [String]? = nil) {
        self.first_name = first_name
        self.hometown = hometown
        self.id = id
        self.last_name = last_name
        self.name = name
        self.role = role
        self.slug = slug
    }
}

public struct PlayerSortObject: SortObject {
    typealias KeyType = PlayerSortObjectKey
    public let keys: [(PlayerSortObjectKey, Bool)]?
    
    public enum PlayerSortObjectKey: String {
        case first_name, hometown, id, image_url, last_name, name, role, slug
    }
}


public extension Client {
    func getPlayers(for type: GroupingType = .all, with id: Int? = nil, page: Int? = nil, per_page: Int? = nil, range: PlayerParameterObject? = nil, filter: PlayerParameterObject? = nil, sort: PlayerSortObject? = nil, completion: @escaping APIResponse<[Player]>) {
        send(GetPlayersForEndpoint(type: type, id: id, page: page, per_page: per_page, filter: filter, range: range, sort: sort), completion: completion)
    }
    func getPlayers(for type: GroupingType = .all, with id: Int? = nil, page: Int? = nil, per_page: Int? = nil, range: PlayerParameterObject? = nil, filter: PlayerParameterObject? = nil, sort: PlayerSortObject? = nil) -> Single<[Player]> {
        return send(GetPlayersForEndpoint(type: type, id: id, page: page, per_page: per_page, filter: filter, range: range, sort: sort))
    }
}

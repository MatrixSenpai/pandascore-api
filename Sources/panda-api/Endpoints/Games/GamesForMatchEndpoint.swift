//
//  GamesForMatchEndpoint.swift
//  panda-api
//
//  Created by Mason Phillips on 4/23/19.
//

import Foundation
import RxSwift

struct GamesForMatchEndpoint: APIRequest {
    typealias Response = [Game]
    typealias Option = GamesForMatchOptions
    var base: String { return "/lol/matches" }
    var endpoint: String {
        return base + "/\(id)/games"
    }
    
    var id: Int
    var options: Option?
    
    struct GamesForMatchOptions: Options {
        typealias RangeObject = GamesForMatchParameterObject
        typealias FilterObject = GamesForMatchParameterObject
        typealias SortObject = GamesForMatchSortObject
        var page: Int?
        var per_page: Int?
        var range: RangeObject?
        var filter: FilterObject?
        var sort: SortObject?
    }
    
    init(id: Int, page: Int?, per_page: Int?, range: GamesForMatchParameterObject?, filter: GamesForMatchParameterObject?, sort: GamesForMatchSortObject?) {
        self.id = id
        self.options = GamesForMatchOptions(page: page, per_page: per_page, range: range, filter: filter, sort: sort)
    }
}

public struct GamesForMatchParameterObject: ParameterObject {
    public let begin_at: [Date]?
    public let finished: [Bool]?
    public let id: [Int]?
    public let length: [Int]?
    public let match_id: [Int]?
    public let position: [Int]?
}

public struct GamesForMatchSortObject: SortObject {
    typealias KeyType = GamesForMatchSortKey
    public let keys: [(GamesForMatchSortKey, Bool)]?
    
    public enum GamesForMatchSortKey: String {
        case begin_at, finished, id, length, match_id, position, winner_type
    }
}

public extension Client {
    func games(for match: Int, page: Int? = nil, per_page: Int? = nil, range: GamesForMatchParameterObject? = nil, filter: GamesForMatchParameterObject? = nil, sort: GamesForMatchSortObject? = nil, completion: @escaping APIResponse<[Game]>) {
        send(GamesForMatchEndpoint(id: match, page: page, per_page: per_page, range: range, filter: filter, sort: sort), completion: completion)
    }
    func games(for match: Int, page: Int? = nil, per_page: Int? = nil, range: GamesForMatchParameterObject? = nil, filter: GamesForMatchParameterObject? = nil, sort: GamesForMatchSortObject? = nil) -> Single<[Game]> {
        return send(GamesForMatchEndpoint(id: match, page: page, per_page: per_page, range: range, filter: filter, sort: sort))
    }
}

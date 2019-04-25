//
//  GetTournamentsEndpoint.swift
//  panda-api
//
//  Created by Mason Phillips on 4/24/19.
//

import Foundation
import RxSwift

struct GetTournamentsEndpoint: APIRequest {
    typealias Response = [Tournament]
    typealias Option = GetTournamentsOptions
    var base: String { return "lol/tournaments" }
    var endpoint: String {
        switch type {
        case .all: return base
        default: return base + "/\(type.rawValue)"
        }
    }
    
    var options: Option?
    
    var type: Timing
    
    init(type: Timing, page: Int?, per_page: Int?, range: TournamentsParameterObject?, filter: TournamentsParameterObject?, sort: TournamentsSortObject?) {
        self.type = type
        self.options = GetTournamentsOptions(page: page, per_page: per_page, range: range, filter: filter, sort: sort)
    }
    
    struct GetTournamentsOptions: Options {
        typealias RangeObject = TournamentsParameterObject
        typealias FilterObject = TournamentsParameterObject
        typealias SortObject = TournamentsSortObject
        var page: Int?
        var per_page: Int?
        var range: RangeObject?
        var filter: FilterObject?
        var sort: SortObject?
    }
}

public struct TournamentsParameterObject: ParameterObject {
    public let begin_at: [Date]?
    public let end_at: [Date]?
    public let id: [Int]?
    public let modified_at: [Date]?
    public let name: [String]?
    public let serie_id: [Int]?
    public let slug: [String]?
    public let winner_id: [Int]?
    
    public init(begin_at: [Date]? = nil, end_at: [Date]? = nil, id: [Int]? = nil, modified_at: [Date]? = nil, name: [String]? = nil, serie_id: [Int]?, slug: [String]? = nil, winner_id: [Int]?) {
        self.begin_at = begin_at
        self.end_at = end_at
        self.id = id
        self.modified_at = modified_at
        self.name = name
        self.serie_id = serie_id
        self.slug = slug
        self.winner_id = winner_id
    }
}

public struct TournamentsSortObject: SortObject {
    typealias KeyType = TournamentsSortKeys
    public let keys: [(TournamentsSortKeys, Bool)]?
    
    public enum TournamentsSortKeys: String {
        case begin_at, end_at, id, league_id, modified_at, name, serie_id, slug, winner_id
    }
    
    public init(_ keys: [(TournamentsSortKeys, Bool)]) {
        self.keys = keys
    }
}

public extension Client {
    func getTournaments(for type: Timing = .all, page: Int? = nil, per_page: Int? = nil, range: TournamentsParameterObject? = nil, filter: TournamentsParameterObject? = nil, sort: TournamentsSortObject? = nil, completion: @escaping APIResponse<[Tournament]>) {
        send(GetTournamentsEndpoint(type: type, page: page, per_page: per_page, range: range, filter: filter, sort: sort), completion: completion)
    }
    func getTournaments(for type: Timing = .all, page: Int? = nil, per_page: Int? = nil, range: TournamentsParameterObject? = nil, filter: TournamentsParameterObject? = nil, sort: TournamentsSortObject? = nil) -> Single<[Tournament]> {
        return send(GetTournamentsEndpoint(type: type, page: page, per_page: per_page, range: range, filter: filter, sort: sort))
    }
}

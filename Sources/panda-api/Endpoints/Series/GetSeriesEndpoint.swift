//
//  GetSeriesEndpoint.swift
//  panda-api
//
//  Created by Mason Phillips on 4/24/19.
//

import Foundation
import RxSwift

struct GetSeriesEndpoint: APIRequest {
    typealias Response = [Serie]
    typealias Option = GetSeriesOptions
    var base: String { return "lol/series" }
    var endpoint: String {
        switch timing {
        case .all: return base
        default: return base + "/\(timing.rawValue)"
        }
    }
    
    var timing: Timing
    var options: Option?
    
    init(timing: Timing, page: Int?, per_page: Int?, filter: SeriesParameterObject?, range: SeriesParameterObject?, sort: SeriesSortObject?) {
        self.timing = timing
        self.options = GetSeriesOptions(page: page, per_page: per_page, range: range, filter: filter, sort: sort)
    }
    
    struct GetSeriesOptions: Options {
        typealias RangeObject = SeriesParameterObject
        typealias FilterObject = SeriesParameterObject
        typealias SortObject = SeriesSortObject
        var page: Int?
        var per_page: Int?
        var range: RangeObject?
        var filter: FilterObject?
        var sort: SortObject?
    }
}

public struct SeriesParameterObject: ParameterObject {
    public let begin_at: [Date]?
    public let description: [String]?
    public let end_at: [Date]?
    public let full_name: [String]?
    public let id: [Int]?
    public let league_id: [Int]?
    public let modified_at: [Date]?
    public let name: [String]?
    public let prizepool: [String]?
    public let season: [String]?
    public let slug: [String]?
    public let winner_id: [Int]?
    public let year: [Int]?
    
    public init(begin_at: [Date]? = nil, description: [String]? = nil, end_at: [Date]? = nil, full_name: [String]? = nil, id: [Int]? = nil, league_id: [Int]? = nil, modified_at: [Date]? = nil, name: [String]? = nil, prizepool: [String]? = nil, season: [String]? = nil, slug: [String]? = nil, winner_id: [Int]? = nil, year: [Int]? = nil) {
        self.begin_at = begin_at
        self.description = description
        self.end_at = end_at
        self.full_name = full_name
        self.id = id
        self.league_id = league_id
        self.modified_at = modified_at
        self.name = name
        self.prizepool = prizepool
        self.season = season
        self.slug = slug
        self.winner_id = winner_id
        self.year = year
    }
}

public struct SeriesSortObject: SortObject {
    typealias KeyType = SeriesSortKeys
    public let keys: [(SeriesSortKeys, Bool)]?
    
    public enum SeriesSortKeys: String {
        case begin_at, description, end_at, full_name, id, league_id, modified_at, name, prizepool, season, slug, winner_id, winner_type, year
    }
    
    public init(_ keys: [(SeriesSortKeys, Bool)]) {
        self.keys = keys
    }
}

public extension Client {
    func getSeries(timing: Timing = .all, page: Int? = nil, per_page: Int? = nil, range: SeriesParameterObject? = nil, filter: SeriesParameterObject? = nil, sort: SeriesSortObject? = nil, completion: @escaping APIResponse<[Serie]>) {
        send(GetSeriesEndpoint(timing: timing, page: page, per_page: per_page, filter: filter, range: range, sort: sort), completion: completion)
    }
    func getSeries(timing: Timing = .all, page: Int? = nil, per_page: Int? = nil, range: SeriesParameterObject? = nil, filter: SeriesParameterObject? = nil, sort: SeriesSortObject? = nil) -> Single<[Serie]> {
        return send(GetSeriesEndpoint(timing: timing, page: page, per_page: per_page, filter: filter, range: range, sort: sort))
    }
}

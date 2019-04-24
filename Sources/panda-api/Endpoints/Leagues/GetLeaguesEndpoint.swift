//
//  GetLeaguesEndpoint.swift
//  panda-api
//
//  Created by Mason Phillips on 4/24/19.
//

import Foundation
import RxSwift

struct GetLeaguesEndpoint: APIRequest {
    typealias Response = [League]
    typealias Option = GetLeaguesOptions
    var base: String { return "lol/leagues" }
    var endpoint: String { return base }
    
    var options: Option?
    
    init(page: Int?, per_page: Int?, range: GetLeaguesParameterObject?, filter: GetLeaguesParameterObject?, sort: GetLeaguesSortObject?) {
        self.options = Option(page: page, per_page: per_page, range: range, filter: filter, sort: sort)
    }
    
    struct GetLeaguesOptions: Options {
        typealias RangeObject = GetLeaguesParameterObject
        typealias FilterObject = GetLeaguesParameterObject
        typealias SortObject = GetLeaguesSortObject
        var page: Int?
        var per_page: Int?
        var range: RangeObject?
        var filter: FilterObject?
        var sort: SortObject?
    }
}

public struct GetLeaguesParameterObject: ParameterObject {
    public let id: [Int]?
    public let live_supported: [Bool]?
    public let modified_at: [Date]?
    public let name: [String]?
    public let slug: [String]?
    
    init(id: [Int]? = nil, live_supported: [Bool]? = nil, modified_at: [Date]? = nil, name: [String]? = nil, slug: [String]? = nil) {
        self.id = id
        self.live_supported = live_supported
        self.modified_at = modified_at
        self.name = name
        self.slug = slug
    }
}

public struct GetLeaguesSortObject: SortObject {
    typealias KeyType = GetLeaguesSortKey
    public let keys: [(GetLeaguesSortKey, Bool)]?
    
    public enum GetLeaguesSortKey: String {
        case id, image_url, live_supported, modified_at, name, slug, url
    }
}

public extension Client {
    func getLeagues(page: Int? = nil, per_page: Int? = nil, range: GetLeaguesParameterObject? = nil, filter: GetLeaguesParameterObject? = nil, sort: GetLeaguesSortObject? = nil, completion: @escaping APIResponse<[League]>) {
        send(GetLeaguesEndpoint(page: page, per_page: per_page, range: range, filter: filter, sort: sort), completion: completion)
    }
    func getLeagues(page: Int? = nil, per_page: Int? = nil, range: GetLeaguesParameterObject? = nil, filter: GetLeaguesParameterObject? = nil, sort: GetLeaguesSortObject? = nil) -> Single<[League]> {
        return send(GetLeaguesEndpoint(page: page, per_page: per_page, range: range, filter: filter, sort: sort))
    }
}

//
//  GetMatchesEndpoint.swift
//  panda-api
//
//  Created by Mason Phillips on 4/24/19.
//

import Foundation
import RxSwift

struct GetMatchesEndpoint: APIRequest {
    typealias Response = [Match]
    typealias Option = GetMatchesOptions
    var base: String { return "lol/matches" }
    var endpoint: String {
        switch timing {
        case .all: return base
        default: return base + "/\(timing.rawValue)"
        }
    }
    
    var timing: Timing
    var options: Option?
    
    init(timing: Timing, page: Int?, per_page: Int?, filter: GetMatchesParameterObject?, range: GetMatchesParameterObject?, sort: GetMatchesSortObject?) {
        self.timing = timing
        self.options = GetMatchesOptions(page: page, per_page: per_page, range: range, filter: filter, sort: sort)
    }
    
    struct GetMatchesOptions: Options {
        typealias RangeObject = GetMatchesParameterObject
        typealias FilterObject = GetMatchesParameterObject
        typealias SortObject = GetMatchesSortObject
        var page: Int?
        var per_page: Int?
        var range: RangeObject?
        var filter: FilterObject?
        var sort: SortObject?
    }
}

public struct GetMatchesParameterObject: ParameterObject {
    public let begin_at: [Date]?
    public let draw: [Bool]?
    public let finished: Bool?
    public let future: Bool?
    public let id: [Int]?
    public let league_id: [Int]?
    public let name: [String]?
    public let not_started: Bool?
    public let number_of_games: [Int]?
    public let past: Bool?
    public let running: Bool?
    public let serie_id: [Int]?
    public let slug: [String]?
    public let tournament_id: [Int]?
    public let unscheduled: Bool?
    public let winner_id: [Int]?
    
    init(begin_at: [Date]? = nil, draw: [Bool]? = nil, finished: Bool? = nil, future: Bool? = nil, id: [Int]? = nil, league_id: [Int]? = nil, name: [String]? = nil, not_started: Bool? = nil, number_of_games: [Int]? = nil, past: Bool? = nil, running: Bool? = nil, serie_id: [Int]? = nil, slug: [String]? = nil, tournament_id: [Int]? = nil, unscheduled: Bool? = nil, winner_id: [Int]? = nil) {
        self.begin_at = begin_at
        self.draw = draw
        self.finished = finished
        self.future = future
        self.id = id
        self.league_id = league_id
        self.name = name
        self.not_started = not_started
        self.number_of_games = number_of_games
        self.past = past
        self.running = running
        self.serie_id = serie_id
        self.slug = slug
        self.tournament_id = tournament_id
        self.unscheduled = unscheduled
        self.winner_id = winner_id
    }
}

public struct GetMatchesSortObject: SortObject {
    typealias KeyType = GetMatchesSortKey
    public let keys: [(GetMatchesSortKey, Bool)]?
    
    public enum GetMatchesSortKey: String {
        case begin_at, draw, id, league_id, match_type, modified_at, name, number_of_games, serie_id, slug, status, tournament_id, winner_id
    }
}

public extension Client {
    func getMatches(timing: Timing = .all, page: Int? = nil, per_page: Int? = nil, range: GetMatchesParameterObject? = nil, filter: GetMatchesParameterObject? = nil, sort: GetMatchesSortObject? = nil, completion: @escaping APIResponse<[Match]>) {
        send(GetMatchesEndpoint(timing: timing, page: page, per_page: per_page, filter: filter, range: range, sort: sort), completion: completion)
    }
    func getMatches(timing: Timing = .all, page: Int? = nil, per_page: Int? = nil, range: GetMatchesParameterObject? = nil, filter: GetMatchesParameterObject? = nil, sort: GetMatchesSortObject? = nil) -> Single<[Match]> {
        return send(GetMatchesEndpoint(timing: timing, page: page, per_page: per_page, filter: filter, range: range, sort: sort))
    }
}

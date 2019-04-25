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

/**
 * A parameter object for the filter or range of a GamesForMatch request
 *
 * The GamesForMatch Parameter Object is designed to allow for filtering
 * items by most of the properties that are available on that object. Each
 * parameter is optional, and can be created with as few or as many as desired.
 *
 * - Invariant:
 *   This item remains the same for the `filter:` and `range:` parameters of each
 *   call, but is optional
 * - Remark:
 *   See the `Game` object for a list and description of each field
 */
public struct GamesForMatchParameterObject: ParameterObject {
    let begin_at: [Date]?
    let finished: [Bool]?
    let id: [Int]?
    let length: [Int]?
    let match_id: [Int]?
    let position: [Int]?
    
    public init(begin_at: [Date]? = nil, finished: [Bool]? = nil, id: [Int]? = nil, length: [Int]? = nil, match_id: [Int]? = nil, position: [Int]? = nil) {
        self.begin_at = begin_at
        self.finished = finished
        self.id = id
        self.length = length
        self.match_id = match_id
        self.position = position
    }
}

/**
 * A parameter object for the sorting of items of a GamesForMatch request
 *
 * The GamesForMatch Sort Object is an array of keys to sort by, and whether
 * those keys should be ascending or decending. Use the enum GamesForMatchSortKey
 * to select a key
 *
 * - Remark:
 *   See the `Game` object for a description of each field
 */
public struct GamesForMatchSortObject: SortObject {
    typealias KeyType = GamesForMatchSortKey
    // Keys should not be modified after set
    internal let keys: [(GamesForMatchSortKey, Bool)]?

    /// The keys used to sort a GameForMatch object
    public enum GamesForMatchSortKey: String {
        case begin_at, finished, id, length, match_id, position, winner_type
    }
    
    public init(_ keys: [(GamesForMatchSortKey, Bool)]) {
        self.keys = keys
    }
}

public extension Client {
    /**
     * List all games for a given match
     * - Parameters:
     *   - match: The match to return games for
     *   - page: The pagination page to return
     *   - per_page: The number of items per page
     *   - range: A range object. See `GamesForMatchParameterObject`
     *   - filter: A filter object. See `GamesForMatchParameterObject`
     *   - sort: A sort object. See `GamesForMatchSortObject`
     *   - completion: Callback with list of champions matching any filters that are applied
     * - SeeAlso: [PandaScore Documentation](https://developers.pandascore.co/doc/#operation/get_lol_champions)
     */
    func getGames(forMatch id: Int, page: Int? = nil, per_page: Int? = nil, range: GamesForMatchParameterObject? = nil, filter: GamesForMatchParameterObject? = nil, sort: GamesForMatchSortObject? = nil, completion: @escaping APIResponse<[Game]>) {
        send(GamesForMatchEndpoint(id: id, page: page, per_page: per_page, range: range, filter: filter, sort: sort), completion: completion)
    }

    /**
     * List all games for a given match
     * - Parameters:
     *   - match: The match to return games for
     *   - page: The pagination page to return
     *   - per_page: The number of items per page
     *   - range: A range object. See `GamesForMatchParameterObject`
     *   - filter: A filter object. See `GamesForMatchParameterObject`
     *   - sort: A sort object. See `GamesForMatchSortObject`
     * - Returns: Emits a single event containing a list of champions matching any filters that are applied
     * - SeeAlso: [PandaScore Documentation](https://developers.pandascore.co/doc/#operation/get_lol_champions)
     */
    func getGames(forMatch id: Int, page: Int? = nil, per_page: Int? = nil, range: GamesForMatchParameterObject? = nil, filter: GamesForMatchParameterObject? = nil, sort: GamesForMatchSortObject? = nil) -> Single<[Game]> {
        return send(GamesForMatchEndpoint(id: id, page: page, per_page: per_page, range: range, filter: filter, sort: sort))
    }
}

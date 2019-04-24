//
//  GetPlayerStatsEndpoint.swift
//  panda-api
//
//  Created by Mason Phillips on 4/24/19.
//

import Foundation
import RxSwift

struct GetPlayerStatsEndpoint: APIRequest {
    typealias Response = StatsPlayer
    typealias Option = GenericOptionsObject
    var base: String { return "lol" }
    var endpoint: String {
        switch type {
        case .all: return base + "/players/\(id)/stats"
        default: return base + "/\(type.rawValue)s/players/\(id)/stats"
        }
    }
    
    var options: Option?
    
    var type: GroupingType
    var id: Int
    
    init(type: GroupingType, id: Int) {
        self.type = type
        self.id = id
        self.options = nil
    }
}

public extension Client {
    func getPlayerStats(for grouping: GroupingType = .all, id: Int, completion: @escaping APIResponse<StatsPlayer>) {
        send(GetPlayerStatsEndpoint(type: grouping, id: id), completion: completion)
    }
    func getPlayerStats(for grouping: GroupingType = .all, id: Int) -> Single<StatsPlayer> {
        return send(GetPlayerStatsEndpoint(type: grouping, id: id))
    }
}

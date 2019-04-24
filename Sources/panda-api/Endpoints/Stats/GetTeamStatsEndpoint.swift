//
//  GetTeamStatsEndpoint.swift
//  panda-api
//
//  Created by Mason Phillips on 4/24/19.
//

import Foundation
import RxSwift

struct GetTeamStatsEndpoint: APIRequest {
    typealias Response = StatsTeam
    typealias Option = GenericOptionsObject
    var base: String { return "lol" }
    var endpoint: String {
        switch type {
        case .all: return base + "/teams/\(id)/stats"
        default: return base + "/\(type.rawValue)/teams/\(id)/stats"
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
    func getTeamStats(for grouping: GroupingType = .all, id: Int, completion: @escaping APIResponse<StatsTeam>) {
        send(GetTeamStatsEndpoint(type: grouping, id: id), completion: completion)
    }
    func getTeamStats(for grouping: GroupingType = .all, id: Int) -> Single<StatsTeam> {
        return send(GetTeamStatsEndpoint(type: grouping, id: id))
    }
}

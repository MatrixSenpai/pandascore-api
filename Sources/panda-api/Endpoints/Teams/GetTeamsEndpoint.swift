//
//  GetTeamsEndpoint.swift
//  panda-api
//
//  Created by Mason Phillips on 4/24/19.
//

import Foundation
import RxSwift

struct GetTeamsEndpoint: APIRequest {
    typealias Response = [Team]
    typealias Option = GenericOptionsObject
    var base: String { return "lol" }
    var endpoint: String {
        switch type {
        case .all: return base + "/teams"
        default:
            guard let id = id else { fatalError("An id must be specified for this type of request!") }
            return base + "/\(type.rawValue)s/players/\(id)/stats"
        }
    }
    
    var options: Option?
    
    var type: GroupingType
    var id: Int?
    
    init(type: GroupingType, id: Int?) {
        self.type = type
        self.id = id
        self.options = nil
    }
}

public extension Client {
    func getTeams(for type: GroupingType = .all, id: Int? = nil, completion: @escaping APIResponse<[Team]>) {
        send(GetTeamsEndpoint(type: type, id: id), completion: completion)
    }
    func getTeams(for type: GroupingType = .all, id: Int? = nil) -> Single<[Team]> {
        return send(GetTeamsEndpoint(type: type, id: id))
    }
}

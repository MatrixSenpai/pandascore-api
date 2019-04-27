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
            return base + "/\(type.rawValue)s/\(id)/teams"
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

public struct GetTeamsParameterObject: ParameterObject {
    public let acronym: [String]?
    public let id: [Int]?
    public let name: [String]?
    public let slug: [String]?
    
    public init(acronym: [String]? = nil, id: [Int]? = nil, name: [String]? = nil, slug: [String]?) {
        self.acronym = acronym
        self.id = id
        self.name = name
        self.slug = slug
    }
}

public struct GetTeamsSortObject: SortObject {
    typealias KeyType = GetTeamsSortKey
    var keys: [(GetTeamsSortObject.KeyType, Bool)]?
    
    public enum GetTeamsSortKey: String {
        case acronym, id, name, slug
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

//
//  GetGamePlayEventsEndpoint.swift
//  panda-api
//
//  Created by Mason Phillips on 4/23/19.
//

import Foundation
import RxSwift

struct GetGamePlayEventsEndpoint: APIRequest {
    typealias Response = [GameEvent]
    typealias Option = GenericOptionsObject
    var base: String { return "lol/games" }
    var endpoint: String { return base + "/\(id)/events" }
    var options: Option?
    
    var id: Int
    
    init(with id: Int, page: Int?, per_page: Int?) {
        self.id = id
        self.options = GenericOptionsObject(page: page, per_page: per_page, range: nil, filter: nil, sort: nil)
    }
}

public extension Client {
    func getPlayByPlayEvents(for game: Int, page: Int? = nil, per_page: Int? = nil, completion: @escaping APIResponse<[GameEvent]>) {
        send(GetGamePlayEventsEndpoint(with: game, page: page, per_page: per_page), completion: completion)
    }
    func getPlayByPlayEvents(for game: Int, page: Int? = nil, per_page: Int? = nil) -> Single<[GameEvent]> {
        return send(GetGamePlayEventsEndpoint(with: game, page: page, per_page: per_page))
    }
}

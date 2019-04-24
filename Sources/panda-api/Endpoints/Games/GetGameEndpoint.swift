//
//  GetGameEndpoint.swift
//  panda-api
//
//  Created by Mason Phillips on 4/23/19.
//

import Foundation
import RxSwift

struct GetGameEndpoint: APIRequest {
    typealias Response = Game
    typealias Option = GenericOptionsObject
    var base: String { return "lol/games" }
    var endpoint: String { return base + "/\(id)" }
 
    var id: Int

    var options: Option?
    
    init(id: Int) {
        self.id = id
        self.options = nil
    }
}

public extension Client {
    func getGame(for id: Int, completion: @escaping APIResponse<Game>) {
        send(GetGameEndpoint(id: id), completion: completion)
    }
    func getGame(for id: Int) -> Single<Game> {
        return send(GetGameEndpoint(id: id))
    }
}

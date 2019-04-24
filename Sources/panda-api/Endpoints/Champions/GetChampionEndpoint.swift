//
//  GetChampionEndpoint.swift
//  panda-api
//
//  Created by Mason Phillips on 4/23/19.
//

import Foundation
import RxSwift

struct GetChampionEndpoint: APIRequest {
    typealias Response = Champion
    typealias Option = GenericOptionsObject
    var base: String { return "lol/champions" }
    var endpoint: String {
        return base + "/\(championID)"
    }
    var options: Option?
    
    var championID: Int
    
    init(with id: Int) {
        self.championID = id
        self.options = nil
    }
}

public extension Client {
    func getChampion(by id: Int, completion: @escaping APIResponse<Champion>) {
        send(GetChampionEndpoint(with: id), completion: completion)
    }
    
    func getChampion(by id: Int) -> Single<Champion> {
        return send(GetChampionEndpoint(with: id))
    }
}

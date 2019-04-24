//
//  GetItemEndpoint.swift
//  panda-api
//
//  Created by Mason Phillips on 4/24/19.
//

import Foundation
import RxSwift

struct GetItemEndpoint: APIRequest {
    typealias Response = Item
    typealias Option = GenericOptionsObject
    var base: String { return "lol/items" }
    var endpoint: String { return base + "/\(id)" }
    var options: Option?
    
    var id: Int
    
    init(id: Int) {
        self.id = id
        self.options = nil
    }
}

public extension Client {
    func getItem(by id: Int, completion: @escaping APIResponse<Item>) {
        send(GetItemEndpoint(id: id), completion: completion)
    }
    func getItem(by id: Int) -> Single<Item> {
        return send(GetItemEndpoint(id: id))
    }
}


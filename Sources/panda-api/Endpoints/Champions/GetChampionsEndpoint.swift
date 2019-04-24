//
//  GetChampionsEndpoint.swift
//  panda-api
//
//  Created by Mason Phillips on 4/23/19.
//

import Foundation
import RxSwift

struct GetChampionsEndpoint: APIRequest {
    typealias Response = [Champion]
    typealias Option = GetChampionsOptions
    var base: String { return "lol/champions" }
    var endpoint: String {
        return base
    }
    var options: Option?
    
    init(ids: [Int]?, page: Int?, per_page: Int?) {
        let f = GetChampionsOptions.Filter(id: ids)
        self.options = GetChampionsOptions(page: page, per_page: per_page, range: nil, filter: f, sort: nil)
    }
    
    struct GetChampionsOptions: Options {
        typealias Range = GenericParameterObject
        typealias Filter = GetChampionFilterObject
        typealias Sort = GenericSortObject
        var page: Int?
        var per_page: Int?
        var range: Range?
        var filter: Filter?
        var sort: Sort?
        
        struct GetChampionFilterObject: ParameterObject {
            var id: [Int]?
        }
    }
}

public extension Client {
    func getChampions(ids: [Int]? = nil, page: Int? = nil, per_page: Int? = nil, completion: @escaping APIResponse<[Champion]>) {
        send(GetChampionsEndpoint(ids: ids, page: page, per_page: per_page), completion: completion)
    }
    
    func getChampions(ids: [Int]? = nil, page: Int? = nil, per_page: Int? = nil) -> Single<[Champion]> {
        return send(GetChampionsEndpoint(ids: ids, page: page, per_page: per_page))
    }
}

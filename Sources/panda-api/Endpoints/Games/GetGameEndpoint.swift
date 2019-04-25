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
    /**
     * Get a single game by ID
     * - Parameters:
     *   - id: The ID of the game
     *   - completion: A single APIResponse callback with a single game
     * - SeeAlso: [PandaScore Documentation](https://developers.pandascore.co/doc/#operation/get_lol_games_lolGameId)
     */
    func getGame(for id: Int, completion: @escaping APIResponse<Game>) {
        send(GetGameEndpoint(id: id), completion: completion)
    }
    /**
     * Get a single game by ID
     * - Parameters:
     *   - id: The ID of the game
     * - Returns: Emits a single event containing a Game object
     * - SeeAlso: [PandaScore Documentation](https://developers.pandascore.co/doc/#operation/get_lol_games_lolGameId)
     */
    func getGame(for id: Int) -> Single<Game> {
        return send(GetGameEndpoint(id: id))
    }
}

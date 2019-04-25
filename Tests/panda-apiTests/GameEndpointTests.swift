//
//  GameEndpointTests.swift
//  panda-api
//
//  Created by Mason Phillips on 4/21/19.
//

import XCTest
import RxSwift
@testable import panda_api

final class GameEndpointTests: XCTestCase {
    let client = Client(ProcessInfo.processInfo.environment["PANDAAPI"] ?? "")
    let bag = DisposeBag()
    
    let errorHandler: (Error) -> Void = { e in print(e); XCTFail() }
    
    func testGetAllGames() {
        let e = self.expectation(description: "Should get all games for LCS Spring Finals 2019 (TL vs TSM)")
        client.getGames(forMatch: 542827).subscribe(onSuccess: { (games) in
            XCTAssertEqual(games.count, 5, "Games count incorrect, expected 5, got \(games.count)")
            guard let first = games.first else { XCTFail("Could not get first game!"); return }
            XCTAssertEqual(first.match.tournament.slug, "league-of-legends-lcs-spring-2019-playoffs", "Wrong match was fetched")
            XCTAssertEqual(first.match.tournament_id, 2189, "Wrong match was fetched")
            e.fulfill()
        }, onError: errorHandler).disposed(by: bag)

        wait(for: [e], timeout: 5.0)
    }
    
    func testGetSingleGame() {
        let e = self.expectation(description: "Should get game 5 of LCS Spring Finals 2019")
        client.getGame(for: 205217).subscribe(onSuccess: { (game) in
            XCTAssertEqual(game.winner.id, 390, "Game winner is wrong or missing")
            XCTAssertEqual(game.position, 5, "Game position is wrong")
            e.fulfill()
        }, onError: errorHandler).disposed(by: bag)
        
        wait(for: [e], timeout: 5.0)
    }
}

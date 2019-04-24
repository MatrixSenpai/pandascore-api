//
//  PlayerEndpointTests.swift
//  panda-apiTests
//
//  Created by Mason Phillips on 4/21/19.
//

import XCTest
import RxSwift
@testable import panda_api

final class PlayerEndpointTests: XCTestCase {
    let client = Client(ProcessInfo.processInfo.environment["PANDAAPI"] ?? "")
    let bag = DisposeBag()
    
    let errorHandler: (Error) -> Void = { e in print(e); XCTFail() }

    func testGetPlayers() {
        let e = self.expectation(description: "Get all players")
        client.getPlayers().subscribe(onSuccess: { players in
            XCTAssertNotNil(players.first)
            e.fulfill()
        }, onError: errorHandler).disposed(by: bag)
        
        wait(for: [e], timeout: 5.0)
    }
    
    func testGetPlayersForSeries() {
        let e = self.expectation(description: "Get players for LCS Spring")
        client.getPlayers(for: .serie, with: 1705).subscribe(onSuccess: { players in
            XCTAssertNotNil(players.first)
            e.fulfill()
        }, onError: errorHandler).disposed(by: bag)
        
        wait(for: [e], timeout: 5.0)
    }
    
    func testGetPlayersForTournament() {
        let e = self.expectation(description: "Get players for LCS Spring Finals 2019")
        client.getPlayers(for: .tournament, with: 2189).subscribe(onSuccess: { players in
            XCTAssertNotNil(players.first)
            e.fulfill()
        }, onError: errorHandler).disposed(by: bag)
        
        wait(for: [e], timeout: 5.0)
    }
}

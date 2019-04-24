//
//  StatsEndpointTests.swift
//  panda-apiTests
//
//  Created by Mason Phillips on 4/21/19.
//

import XCTest
import RxSwift
@testable import panda_api

final class StatsEndpointTests: XCTestCase {
    let client = Client(ProcessInfo.processInfo.environment["PANDAAPI"] ?? "")
    let bag = DisposeBag()
    
    let errorHandler: (Error) -> Void = { e in print(e); XCTFail() }
    
    func testGetPlayer() {
        let e = self.expectation(description: "Get stats for Bjergsen")
        
        client.getPlayerStats(id: 40).subscribe(onSuccess: { (player) in
            XCTAssertEqual(player.name, "Bjergsen")
            XCTAssertEqual(player.role, .mid)
            e.fulfill()
        }, onError: errorHandler).disposed(by: bag)
        
        wait(for: [e], timeout: 3.0)
    }
    
    func testGetTeam() {
        let e = self.expectation(description: "Get stats for TSM")
        
        client.getTeamStats(id: 387).subscribe(onSuccess: { (team) in
            XCTAssertEqual(team.name, "TSM")
            e.fulfill()
        }, onError: errorHandler).disposed(by: bag)
        
        wait(for: [e], timeout: 3.0)
    }
}

//
//  TeamsEndpointTests.swift
//  panda-apiTests
//
//  Created by Mason Phillips on 4/21/19.
//

import XCTest
import RxSwift
@testable import panda_api

final class TeamsEndpointTests: XCTestCase {
    let client = Client(ProcessInfo.processInfo.environment["PANDAAPI"] ?? "")
    let bag = DisposeBag()
    
    let errorHandler: (Error) -> Void = { e in print(e); XCTFail() }

    func testGetTeams() {
        let e = self.expectation(description: "Get all teams")
        
        client.getTeams().subscribe(onSuccess: { teams in
            XCTAssertNotNil(teams.first)
            e.fulfill()
        }, onError: errorHandler).disposed(by: bag)
        
        wait(for: [e], timeout: 5.0)
    }
}

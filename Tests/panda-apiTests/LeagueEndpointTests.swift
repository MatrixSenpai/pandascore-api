//
//  LeagueEndpointTests.swift
//  panda-apiTests
//
//  Created by Mason Phillips on 4/21/19.
//

import XCTest
import RxSwift
@testable import panda_api

final class LeagueEndpointTests: XCTestCase {
    let client = Client(ProcessInfo.processInfo.environment["PANDAAPI"] ?? "")
    let bag = DisposeBag()
    
    let errorHandler: (Error) -> Void = { e in print(e); XCTFail() }
    
    func testGetLeagues() {
        let e = self.expectation(description: "Should get leagues")
        client.getLeagues().subscribe(onSuccess: { leagues in
            XCTAssertNotNil(leagues.first)
            e.fulfill()
        }, onError: errorHandler).disposed(by: bag)
        
        let ee = self.expectation(description: "Get NA LCS")
        let filter = GetLeaguesParameterObject(id: [4198])
        client.getLeagues(filter: filter).subscribe(onSuccess: { leagues in
            XCTAssertNotNil(leagues.first)
            ee.fulfill()
        }, onError: errorHandler).disposed(by: bag)
        
        wait(for: [e, ee], timeout: 5.0)
    }
}

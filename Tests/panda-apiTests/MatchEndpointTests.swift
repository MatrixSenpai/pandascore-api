//
//  MatchEndpointTests.swift
//  panda-apiTests
//
//  Created by Mason Phillips on 4/21/19.
//

import XCTest
import RxSwift
@testable import panda_api

final class MatchEndpointTests: XCTestCase {
    let client = Client(ProcessInfo.processInfo.environment["PANDAAPI"] ?? "")
    let bag = DisposeBag()
    
    let errorHandler: (Error) -> Void = { e in print(e); XCTFail() }
    
    func testAllMatches() {
        let e = self.expectation(description: "Get all matches")
        client.getMatches().subscribe(onSuccess: { matches in
            XCTAssertNotNil(matches.first)
            e.fulfill()
        }, onError: errorHandler).disposed(by: bag)
        
        wait(for: [e], timeout: 5.0)
    }
    
    func testPastMatches() {
        let e = self.expectation(description: "Get past matches")
        client.getMatches(timing: .past).subscribe(onSuccess: { matches in
            XCTAssertNotNil(matches.first)
            e.fulfill()
        }, onError: errorHandler).disposed(by: bag)
        
        wait(for: [e], timeout: 5.0)
    }

    func testRunningMatches() {
        let e = self.expectation(description: "Get running matches")
        client.getMatches(timing: .running).subscribe(onSuccess: { matches in
            // Just assert true if this succeeds
            e.fulfill()
        }, onError: errorHandler).disposed(by: bag)
        
        wait(for: [e], timeout: 5.0)
    }

    func testUpcomingMatches() {
        let e = self.expectation(description: "Get upcoming matches")
        client.getMatches(timing: .upcoming).subscribe(onSuccess: { matches in
            // Just assert true if this succeeds
            e.fulfill()
        }, onError: errorHandler).disposed(by: bag)
        
        wait(for: [e], timeout: 5.0)
    }

}

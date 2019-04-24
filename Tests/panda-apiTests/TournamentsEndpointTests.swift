//
//  TournamentsEndpointTests.swift
//  panda-apiTests
//
//  Created by Mason Phillips on 4/24/19.
//

import XCTest
import RxSwift
@testable import panda_api

final class TournamentsEndpointTests: XCTestCase {
    let client = Client(ProcessInfo.processInfo.environment["PANDAAPI"] ?? "")
    let bag = DisposeBag()
    
    let errorHandler: (Error) -> Void = { e in print(e); XCTFail() }

    func testGetTournaments() {
        let e = self.expectation(description: "Get tournaments")
        
        client.getTournaments().subscribe(onSuccess: { (tournaments) in
            XCTAssertNotNil(tournaments.first)
            e.fulfill()
        }, onError: errorHandler).disposed(by: bag)
        
        wait(for: [e], timeout: 5.0)
    }
}

//
//  SeriesEndpointTests.swift
//  panda-apiTests
//
//  Created by Mason Phillips on 4/21/19.
//

import XCTest
import RxSwift
@testable import panda_api

final class SeriesEndpointTests: XCTestCase {
    let client = Client(ProcessInfo.processInfo.environment["PANDAAPI"] ?? "")
    let bag = DisposeBag()
    
    let errorHandler: (Error) -> Void = { e in print(e); XCTFail() }
    
    func testGetAllSeries() {
        let e = self.expectation(description: "Get all series")
        
        client.getSeries().subscribe(onSuccess: { series in
            XCTAssertNotNil(series.first)
            e.fulfill()
        }, onError: errorHandler).disposed(by: bag)
        
        wait(for: [e], timeout: 2.0)
    }
    
    func testGetPastSeries() {
        let e = self.expectation(description: "Get past series")
        
        client.getSeries(timing: .past).subscribe(onSuccess: { series in
            XCTAssertNotNil(series.first)
            e.fulfill()
        }, onError: errorHandler).disposed(by: bag)
        
        wait(for: [e], timeout: 2.0)
    }
    
    func testGetRunningSeries() {
        let e = self.expectation(description: "Get running series")
        
        client.getSeries(timing: .running).subscribe(onSuccess: { series in
            XCTAssertNotNil(series.first)
            e.fulfill()
        }, onError: errorHandler).disposed(by: bag)
        
        wait(for: [e], timeout: 2.0)
    }

    func testGetUpcomingSeries() {
        let e = self.expectation(description: "Get upcoming series")
        
        client.getSeries(timing: .upcoming).subscribe(onSuccess: { series in
            // Since rn there's no upcoming series, just pass if it succeeds
            e.fulfill()
        }, onError: errorHandler).disposed(by: bag)
        
        wait(for: [e], timeout: 2.0)
    }
}

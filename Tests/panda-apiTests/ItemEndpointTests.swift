//
//  ItemEndpointTests.swift
//  panda-apiTests
//
//  Created by Mason Phillips on 4/21/19.
//

import XCTest
import RxSwift
@testable import panda_api

final class ItemEndpointTests: XCTestCase {
    let client = Client(ProcessInfo.processInfo.environment["PANDAAPI"] ?? "")
    let bag = DisposeBag()

    let errorHandler: (Error) -> Void = { e in print(e); XCTFail() }
    
    func testGetItems() {
        let e = self.expectation(description: "Should get 50 items")
        client.getItems().subscribe(onSuccess: { items in
            XCTAssertEqual(items.count, 50, "Not 50?")
            e.fulfill()
        }, onError: errorHandler).disposed(by: bag)
        
        wait(for: [e], timeout: 5.0)
    }
}

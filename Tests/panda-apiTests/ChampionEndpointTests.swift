//
//  ChampionEndpointTests.swift
//  panda-apiTests
//
//  Created by Mason Phillips on 4/22/19.
//

import XCTest
import RxSwift
@testable import panda_api

final class ChampionsEndpointTests: XCTestCase {
    let client = Client(ProcessInfo.processInfo.environment["PANDAAPI"] ?? "")
    let bag = DisposeBag()
    
    let errorHandler: (Error) -> Void = { e in print(e); XCTFail() }

    func testGetChampion() {
        let e = self.expectation(description: "Get Syndra")
        
        client.getChampion(by: 2442).subscribe(onSuccess: { (champion) in
            XCTAssertEqual(champion.name, "Syndra")
            e.fulfill()
        }, onError: errorHandler).disposed(by: bag)
        
        wait(for: [e], timeout: 2.0)
    }
    
    func testGetChampionsWithPaging() {
        let e = self.expectation(description: "Get 3 champions")
        
        client.getChampions(page: 1, per_page: 3).subscribe(onSuccess: { (champs) in
            XCTAssertEqual(champs.count, 3)
            e.fulfill()
        }, onError: errorHandler).disposed(by: bag)
        
        wait(for: [e], timeout: 5.0)
    }
    
    func testGetChampions() {
        let e = self.expectation(description: "Get multiple champions")
        
        client.getChampions(ids: [2442, 2456, 2398]).subscribe(onSuccess: { champions in
            XCTAssertEqual(champions.count, 3)
            e.fulfill()
        }, onError: errorHandler).disposed(by: bag)
        
        wait(for: [e], timeout: 2.0)
    }
}

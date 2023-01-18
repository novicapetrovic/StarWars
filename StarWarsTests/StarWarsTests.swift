//
//  StarWarsTests.swift
//  StarWarsTests
//
//  Created by Nov Petrović on 16/01/2023.
//

import XCTest
@testable import StarWars

final class StarWarsTests: XCTestCase {
    
    var listViewController: ListViewController!

    override func setUp() {
        super.setUp()
        listViewController = ListViewController()
    }
    
    func testListViewController() {
        listViewController.loadViewIfNeeded()
        XCTAssertEqual(listViewController.title, "Star Wars Films")
    }
}

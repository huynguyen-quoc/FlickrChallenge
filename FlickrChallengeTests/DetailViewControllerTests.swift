//
//  DetailViewControllerTests.swift
//  FlickrChallengeTests
//
//  Created by Huy Nguyen on 12/2/17.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import XCTest
@testable import FlickrChallenge

class DetailViewControllerTests: XCTestCase {
    var vc: DetailViewController!
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: DetailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        self.vc = vc
        _ = self.vc.view
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testViewControllerCanInstantiateViewController() {
        XCTAssertNotNil(vc)
    }
    
    func testViewControllerCollectionViewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(vc.tableView)
    }
    
    func testViewControllerShouldSetCollectionViewDataSource() {
        XCTAssertNotNil(vc.tableView.dataSource)
    }
    
    func testViewControllerShouldSetCollectionViewDelegate() {
        XCTAssertNotNil(vc.tableView.delegate)
    }
    
    func testViewControllerConformsToCollectionViewDataSource() {
        XCTAssert(vc.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(vc.responds(to: #selector(vc.tableView(_:titleForHeaderInSection:))))
        XCTAssertTrue(vc.responds(to: #selector(vc.tableView(_:cellForRowAt:))))
    }
    
    func testTableViewHeaderAsExpected() {
        let header = self.vc.tableView(self.vc.tableView, titleForHeaderInSection: 0)
        XCTAssertTrue(header == "Owner", "TableView header must be Owner")
        let header2 = self.vc.tableView(self.vc.tableView, titleForHeaderInSection: 1)
        XCTAssertTrue(header2 == "Comments", "TableView header must be Comments")
    }
    
    
}

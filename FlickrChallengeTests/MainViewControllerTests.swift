//
//  MainViewControllerTests.swift
//  FlickrChallengeTests
//
//  Created by Huy Nguyen on 12/2/17.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import XCTest
@testable import FlickrChallenge

class MainViewControllerTests: XCTestCase {
    var vc:MainViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: MainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
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
        XCTAssertNotNil(vc.collectionView)
    }
    
    func testViewControllerShouldSetCollectionViewDataSource() {
        XCTAssertNotNil(vc.collectionView.dataSource)
    }
    
    func testViewControllerShouldSetCollectionViewDelegate() {
        XCTAssertNotNil(vc.collectionView.delegate)
    }

    func testViewControllerConformsToCollectionViewDataSource() {
        XCTAssert(vc.conforms(to: UICollectionViewDataSource.self))
        XCTAssertTrue(vc.responds(to: #selector(vc.collectionView(_:numberOfItemsInSection:))))
        XCTAssertTrue(vc.responds(to: #selector(vc.collectionView(_:cellForItemAt:))))
    }
    
    func testViewControllerConformsToCollectionViewDelegate() {
        XCTAssert(vc.conforms(to: UICollectionViewDelegate.self))
        XCTAssertTrue(vc.responds(to: #selector(vc.collectionView(_:willDisplay:forItemAt:))))
    }
    
    func testViewControllerSegmentChanged() {
        self.vc.segmentControl.selectedSegmentIndex = 0
        self.vc.segmentedControlDidChanged(self.vc.segmentControl)
        XCTAssertTrue(self.vc.layoutType == LayoutType.Grid, "Layout should equal Grid")
        self.vc.segmentControl.selectedSegmentIndex = 1
        self.vc.segmentedControlDidChanged(self.vc.segmentControl)
        XCTAssertTrue(self.vc.layoutType == LayoutType.List, "Layout should equal List")
    }
}

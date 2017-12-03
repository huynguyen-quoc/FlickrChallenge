//
//  MainViewControllerSpec.swift
//  FlickrChallenge
//
//  Created by Huy Nguyen on 12/3/17.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import Quick
import Nimble
import UIKit
@testable import FlickrChallenge

class MainViewControllerSpec: QuickSpec {
    override func spec() {
        describe("MainViewController") {
            var subject: MainViewController!
            beforeEach {
                subject = UIStoryboard(name: "Main", bundle:
                nil).instantiateViewController(withIdentifier:
                "MainViewController") as! MainViewController
                _ = subject.view
            }

            context("when the view loaded") {
                it("should have collection view") {
                    expect(subject.collectionView != nil).to(beTrue())
                }
                it("initially has an empty collection view") {
                    expect(subject.collectionView.numberOfItems(inSection: 0)).to(equal(0))
                }
                it("has only one co section in llection view") {
                    expect(subject.collectionView.numberOfSections).to(equal(1))
                }
            }
            
            context("when segment is did changed to index 0") {
                it("should have layout is grid") {
                    subject.segmentControl.selectedSegmentIndex = 0
                    subject.segmentedControlDidChanged(subject.segmentControl)
                    expect(subject.layoutType == LayoutType.Grid).to(beTrue())
                }
            }
            
            context("when segment is did changed to index 1") {
                it("should have layout is list") {
                    subject.segmentControl.selectedSegmentIndex = 1
                    subject.segmentedControlDidChanged(subject.segmentControl)
                    expect(subject.layoutType == LayoutType.List).to(beTrue())
                }
            }

            context("when has photos") {
                beforeEach {
                    subject.photos = [
                        ["url_z" : "https://test.com"],
                        ["url_z" : "https://test2.com"]
                    ]
                }
                context("when segment is did changed to index 1") {
                    it("shows a list of photo in list") {
                        subject.layoutType = LayoutType.List
                        expect(subject.collectionView.numberOfSections).to(equal(1))
                        expect(subject.collectionView.numberOfItems(inSection: 0)).to(equal(2))
                        
                        let cell:PhotoCollectionViewCell? = subject.collectionView(subject.collectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as? PhotoCollectionViewCell
                        expect(cell != nil ).to(beTrue())
                        expect(cell?.reuseIdentifier).to(equal("PhotoCell"))
                        expect(cell?.image.image != nil).to(beTrue())
                    }
                }
                
                context("when segment is did changed to index 0") {
                    it("shows a list of photo in grid") {
                        subject.layoutType = LayoutType.Grid
                        expect(subject.collectionView.numberOfSections).to(equal(1))
                        expect(subject.collectionView.numberOfItems(inSection: 0)).to(equal(2))
                        
                        let cell:PhotoCollectionViewCell? = subject.collectionView(subject.collectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as? PhotoCollectionViewCell
                        expect(cell != nil ).to(beTrue())
                        expect(cell?.reuseIdentifier).to(equal("PhotoCell"))
                        expect(cell?.image.image != nil).to(beTrue())
                    }
                }
            }
            
        }
    }
    
}

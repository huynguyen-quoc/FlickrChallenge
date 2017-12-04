//
//  DetailViewControllerSpec.swift
//  FlickrChallenge
//
//  Created by Huy Nguyen on 12/3/17.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import Quick
import Nimble
import UIKit
@testable import FlickrChallenge

class DetailViewControllerSpec: QuickSpec {

    override func spec() {
        describe("DetailViewController") {
            var subject: DetailViewController!
            beforeEach {
                subject = UIStoryboard(name: "Main", bundle:
                nil).instantiateViewController(withIdentifier:
                "DetailViewController") as! DetailViewController
                _ = subject.view
            }

            context("when the view loaded") {
                it("should have table view") {
                    expect(subject.tableView != nil).to(beTrue())
                }
                it("initially has an loading table view") {
                    expect(subject.tableView.numberOfRows(inSection: 0)).to(equal(1))
                    let cell1: LoadingTableViewCell? = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? LoadingTableViewCell
                    expect(cell1 != nil).to(beTrue())
                    expect(subject.tableView.numberOfRows(inSection: 1)).to(equal(1))
                    let cell2: LoadingTableViewCell? = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 1)) as? LoadingTableViewCell
                    expect(cell2 != nil).to(beTrue())
                }
                it("has 2 sections in table view") {
                    expect(subject.tableView.numberOfSections).to(equal(2))
                }
            }

            context("when has user profile") {
                beforeEach {
                    subject.username = "username"
                    subject.isLoadingUser = false
                    subject.error["username"] = nil

                }
                it("shows a user name owner") {
                    expect(subject.tableView.numberOfSections).to(equal(2))
                    expect(subject.tableView.numberOfRows(inSection: 0)).to(equal(1))

                    let cell: UserPhotoTableViewCell? = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? UserPhotoTableViewCell
                    expect(cell != nil).to(beTrue())
                    expect(cell?.reuseIdentifier).to(equal("UserCell"))
                    expect(cell?.txtUserId.text).to(equal("username"))
                }
            }

            context("when get user profile error") {
                beforeEach {
                    subject.username = "username"
                    subject.error["username"] = "Error"
                    subject.isLoadingUser = false

                }
                it("shows a error") {
                    expect(subject.tableView.numberOfSections).to(equal(2))
                    expect(subject.tableView.numberOfRows(inSection: 0)).to(equal(1))

                    let cell: ErrorTableViewCell? = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? ErrorTableViewCell
                    expect(cell != nil).to(beTrue())
                    expect(cell?.reuseIdentifier).to(equal("ErrorCell"))
                    expect(cell?.txtError.text).to(equal("Error"))
                }
            }

            context("when has comments") {
                beforeEach {
                    subject.comments = [
                        [
                            "_content" : "Comment 1",
                            "authorname" : "author 1"
                        ],
                        [
                            "_content" : "Comment 2",
                            "authorname" : "author 2"
                        ]
                    ]
                    subject.isLoadingComments = false
                    subject.error["comments"] = nil

                }
                it("shows a comments for photo") {
                    expect(subject.tableView.numberOfSections).to(equal(2))
                    expect(subject.tableView.numberOfRows(inSection: 1)).to(equal(2))

                    let cell: CommentTableViewCell? = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 1)) as? CommentTableViewCell
                    expect(cell != nil).to(beTrue())
                    expect(cell?.reuseIdentifier).to(equal("CommentCell"))
                    expect(cell?.txtComment.text).to(equal("Comment 1"))
                    expect(cell?.txtUserId.text).to(equal("author 1"))
                }
            }

            context("when get comments error") {
                beforeEach {
                    subject.comments = [
                        [
                            "_content" : "Comment 1",
                            "authorname" : "author 1"
                        ],
                        [
                            "_content" : "Comment 2",
                            "authorname" : "author 2"
                        ]
                    ]
                    subject.error["comments"] = "Error"
                    subject.isLoadingComments = false

                }
                it("shows an error") {
                    expect(subject.tableView.numberOfSections).to(equal(2))
                    expect(subject.tableView.numberOfRows(inSection: 1)).to(equal(1))

                    let cell: ErrorTableViewCell? = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 1)) as? ErrorTableViewCell
                    expect(cell != nil).to(beTrue())
                    expect(cell?.reuseIdentifier).to(equal("ErrorCell"))
                    expect(cell?.txtError.text).to(equal("Error"))
                }
            }

            context("when get no comments ") {
                beforeEach {
                    subject.comments = []
                    subject.error["comments"] = "No result"
                    subject.isLoadingComments = false

                }
                it("shows no result") {
                    expect(subject.tableView.numberOfSections).to(equal(2))
                    expect(subject.tableView.numberOfRows(inSection: 1)).to(equal(1))

                    let cell: ErrorTableViewCell? = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 1)) as? ErrorTableViewCell
                    expect(cell != nil).to(beTrue())
                    expect(cell?.reuseIdentifier).to(equal("ErrorCell"))
                    expect(cell?.txtError.text).to(equal("No result"))
                }
            }

        }
    }
    
}

//
//  FlickrServiceSpec.swift
//  FlickrChallenge
//
//  Created by Huy Nguyen on 12/3/17.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import Quick
import Nimble
import TRON
import SwiftyJSON
@testable import FlickrChallenge

class FlickrServiceSpec: QuickSpec {

    override func spec() {
        var subject: FlickrService!

        beforeEach {
            subject = FlickrService()
        }

        describe("getting request of flickr photo") {
            var request : APIRequest<FlickPhotoResponse, AppError>!
            beforeEach {
                request = subject.readPhotos(pageSize: 20, page: 1)
                request.stubbingEnabled = true
            }

            it("should have return not nil request") {
                expect(subject != nil).to(beTrue())
            }

        }

        describe("getting request of flickr comments") {
            var request : APIRequest<FlickCommentResponse, AppError>!
            beforeEach {
                request = subject.readComments(id: "testId")
                request.stubbingEnabled = true
            }

            it("should have return not nil request") {
                expect(subject != nil).to(beTrue())
            }

        }

        describe("getting request of flickr user profile") {
            var request : APIRequest<FlickUserResponse, AppError>!
            beforeEach {
                request = subject.readUserProfile(id: "testId")
                request.stubbingEnabled = true
            }

            it("should have return not nil request") {
                expect(subject != nil).to(beTrue())
            }

        }
    }
    
}

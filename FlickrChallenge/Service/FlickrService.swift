//
//  FlickrService.swift
//  FlickrChallenge
//
//  Created by Huy Nguyen on 12/2/17.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import Foundation
import TRON
import SwiftyJSON

class FlickPhotoResponse: JSONDecodable {
    var page:Int
    var pages:Int
    var perPage:Int
    var total:Int
    var photo:[[String:Any]]
    required init(json : JSON) {
        let data:[String:Any] = json.dictionaryObject!
        let photos:[String:Any] = data["photos"] as! [String:Any]
        self.page = photos["page"] as! Int
        self.pages = photos["pages"] as! Int
        self.perPage = photos["perpage"] as! Int
        self.total = photos["total"] as! Int
        self.photo = photos["photo"] as! [[String:Any]]
    }
}

class FlickCommentResponse: JSONDecodable {
    var photoId:String
    var comments:[[String:Any]]?
    required init(json : JSON) {
        let data:[String:Any] = json.dictionaryObject!
        let commentDict:[String:Any] = data["comments"] as! [String:Any]
        self.photoId = commentDict["photo_id"] as! String
        self.comments = commentDict["comment"] as? [[String:Any]]
    }
}

class FlickUserResponse: JSONDecodable {
    var username:[String:Any]?
    required init(json : JSON) {
        let data:[String:Any] = json.dictionaryObject!
        let userProfile:[String:Any]? = data["person"] as? [String:Any]
        self.username = userProfile == nil ? nil : (userProfile!["username"] as? [String : Any])
    }
}


class AppError: JSONDecodable {
    required init(json : JSON) {
        
    }
}
class FlickrRequestFactory {
    
    static let tron = TRON(baseURL: "https://api.flickr.com/services/rest")
    static let API_KEY:String = "23a868882f94ae2ecc5bc49ea78cda51"
    
    static func readPhotos(pageSize:Int, page:Int) -> APIRequest<FlickPhotoResponse, AppError>  {
        let request: APIRequest<FlickPhotoResponse, AppError> = tron.swiftyJSON.request("")
        request.method = .get
        let parameters : [String : Any] = [
            "method"         : "flickr.photos.getRecent",
            "api_key"        : API_KEY,
            "per_page"       : pageSize,
            "format"         : "json",
            "nojsoncallback" : true,
            "page"           : page,
            "extras"         : "url_q,url_z"
            ]
        request.parameters = parameters
        return request
    }
    
    static func readComments(id:String) -> APIRequest<FlickCommentResponse, AppError> {
        let request: APIRequest<FlickCommentResponse, AppError> = tron.swiftyJSON.request("")
        request.method = .get
        let parameters : [String : Any] = [
            "method"         : "flickr.photos.comments.getList",
            "api_key"        : API_KEY,
            "photo_id"       : id,
            "format"         : "json",
            "nojsoncallback" : true
        ]
        request.parameters = parameters
        
        return request
    }
    
    static func readUserProfile(id: String) -> APIRequest<FlickUserResponse, AppError> {
        let request: APIRequest<FlickUserResponse, AppError> = tron.swiftyJSON.request("")
        request.method = .get
        let parameters : [String : Any] = [
            "method"         : "flickr.people.getInfo",
            "api_key"        : API_KEY,
            "user_id"        :  id,
            "format"         : "json",
            "nojsoncallback" : true
        ]
        request.parameters = parameters
        return request
    }
}

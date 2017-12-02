//
//  DetailViewController.swift
//  FlickrChallenge
//
//  Created by Huy Nguyen on 12/2/17.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    struct Storyboard {
        static let commentCell = "CommentCell"
        static let errorCell = "ErrorCell"
        static let loadingCell = "LoadingCell"
        static let ownerCell = "UserCell"
        
        static let loadingUserNameMessage = "Loading user name..."
        static let loadingCommentsMessage = "Loading comments..."
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    var comments : [[String:Any]] = []
    var userId : String = ""
    var photoId: String = ""
    var username: String = ""
    var isLoadingUser: Bool = true
    var isLoadingComments: Bool = true
    var error:[String : String?] = [
        "username" : nil,
        "comments" : nil
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViewController()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.fetchUsers()
        self.fetchComments()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initViewController() {
        self.tableView.tableFooterView?.frame = CGRect.zero
    }
    
    private func fetchUsers() {
        self.isLoadingUser = true
        self.error["username"] = nil
        let request = FlickrRequestFactory.readUserProfile(id: self.userId)
        request.perform(withSuccess: { response in
            self.username = response.username == nil ? "" : response.username!["_content"] as! String
            self.isLoadingUser = false
            self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }) { (error) in
            self.isLoadingUser = false
            self.error["username"] = "There are some problems occured. Please contact administrator"
            self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            debugPrint("\(error)")
            
        }
    }
    
    private func fetchComments() {
        self.isLoadingComments = true
        self.error["comments"] = nil
        let request = FlickrRequestFactory.readComments(id: self.photoId)
        request.perform(withSuccess: { response in
            self.comments += response.comments == nil ? [] : response.comments!
            self.isLoadingComments  = false
            if self.comments.count == 0 {
                self.error["comments"] = "No comments"
            }
            self.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
        }) { (error) in
            self.isLoadingComments  = false
            self.error["comments"] = "There are some problems occured. Please contact administrator"
            debugPrint("\(error)")
            self.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
        }
    }

    @IBAction func backButtonClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
}

extension DetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Owner"
        } else {
            return "Comments"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if !isLoadingComments {
                if let _ = self.error["comments"] {
                   return 1
                } else {
                    return self.comments.count
                }
            } else  {
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        if section == 0 {
            if !isLoadingUser {
                if let error = self.error["username"] {
                    let cell: ErrorTableViewCell = tableView.dequeueReusableCell(withIdentifier: Storyboard.errorCell, for: indexPath) as! ErrorTableViewCell
                    cell.txtError.text = error
                    return cell
                } else {
                    let cell: UserPhotoTableViewCell = tableView.dequeueReusableCell(withIdentifier: Storyboard.ownerCell, for: indexPath) as! UserPhotoTableViewCell
                    cell.txtUserId.text = self.username
                    return cell
                }
            } else {
                let cell:LoadingTableViewCell = tableView.dequeueReusableCell(withIdentifier: Storyboard.loadingCell , for: indexPath) as! LoadingTableViewCell
                cell.txtLoading.text = Storyboard.loadingUserNameMessage
                return cell
            }
        } else {
            if !isLoadingComments {
                if let error = self.error["comments"] {
                    let cell: ErrorTableViewCell = tableView.dequeueReusableCell(withIdentifier: Storyboard.errorCell, for: indexPath) as! ErrorTableViewCell
                    cell.txtError.text = error
                    return cell
                } else {
                    let cell: CommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: Storyboard.commentCell, for: indexPath) as! CommentTableViewCell
                    let row = indexPath.row
                    let comment = self.comments[row]
                    cell.txtComment.text = comment["_content"] as? String
                    cell.txtUserId.text = comment["authorname"] as? String
                    return cell
                }
            } else {
                let cell:LoadingTableViewCell = tableView.dequeueReusableCell(withIdentifier: Storyboard.loadingCell, for: indexPath) as! LoadingTableViewCell
                cell.txtLoading.text = Storyboard.loadingCommentsMessage
                return cell
            }
        }
    }
}

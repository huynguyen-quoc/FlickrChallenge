//
//  UserPhotoTableViewCell.swift
//  FlickrChallenge
//
//  Created by Huy Nguyen on 12/2/17.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import UIKit

class UserPhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var txtUserId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

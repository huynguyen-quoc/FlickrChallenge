//
//  LoadingTableViewCell.swift
//  FlickrChallenge
//
//  Created by Huy Nguyen on 12/2/17.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {

    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var txtLoading: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

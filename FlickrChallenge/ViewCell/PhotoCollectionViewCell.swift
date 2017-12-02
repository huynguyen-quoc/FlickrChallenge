//
//  PhotoCollectionViewCell.swift
//  FlickrChallenge
//
//  Created by Huy Nguyen on 12/2/17.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.image.image = nil
    }
}

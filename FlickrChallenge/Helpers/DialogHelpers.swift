//
//  DialogHelpers.swift
//  FlickrChallenge
//
//  Created by Huy Nguyen on 12/3/17.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import Foundation
import UIKit
protocol DialogDelegate {
    func presentAlert(title: String, message: String, onAction:(() -> Void)?, onTopOf presenter: UIViewController)
}

class DialogHelper: DialogDelegate {
    func presentAlert(title: String, message: String, onAction: (() -> Void)?, onTopOf presenter: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        presenter.present(alert, animated: true, completion: onAction)
    }
}

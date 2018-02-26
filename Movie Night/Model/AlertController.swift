//
//  AlertController.swift
//  Movie Night
//
//  Created by Garrett Votaw on 2/26/18.
//  Copyright © 2018 Garrett Votaw. All rights reserved.
//

import Foundation
import UIKit

class AlertController {
    static func presentAlert(withView view: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        view.present(alert, animated: true, completion: nil)
    }
}

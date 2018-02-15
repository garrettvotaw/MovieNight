//
//  ViewController.swift
//  Movie Night
//
//  Created by Garrett Votaw on 1/27/18.
//  Copyright © 2018 Garrett Votaw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstUserButton: UIButton!
    @IBOutlet weak var secondUserButton: UIButton!
    @IBOutlet weak var firstUserStatusLabel: UILabel!
    @IBOutlet weak var secondUserStatusLabel: UILabel!
    @IBOutlet weak var viewResultsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        reloadView()
        if !User1.isReady && !User2.isReady {
            viewResultsButton.isHidden = true
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        reloadView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func firstUserSelected() {
        User1.isSelected = true
        User2.isSelected = false
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func secondUserSelected() {
        User1.isSelected = false
        User2.isSelected = true
        dismiss(animated: true, completion: nil)
    }
    
    func reloadView() {
        if User1.isReady {
            firstUserButton.setImage(#imageLiteral(resourceName: "UserSelected"), for: .normal)
            firstUserStatusLabel.text = "Ready!"
        } else {
            firstUserButton.setImage(#imageLiteral(resourceName: "UserUnselected"), for: .normal)
            firstUserStatusLabel.text = "Tap here to enter preferences."
        }
        
        if User2.isReady {
            secondUserButton.setImage(#imageLiteral(resourceName: "UserSelected"), for: .normal)
            secondUserStatusLabel.text = "Ready!"
        } else {
            secondUserButton.setImage(#imageLiteral(resourceName: "UserUnselected"), for: .normal)
            secondUserStatusLabel.text = "Tap here to enter preferences."
        }
    }
    
    @IBAction func viewResultsPressed() {
        if User1.isReady && User2.isReady {
            performSegue(withIdentifier: "viewResultsPage", sender: nil)
        }
    }
    
    
    
}


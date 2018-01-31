//
//  GenreTableViewCell.swift
//  Movie Night
//
//  Created by Garrett Votaw on 1/31/18.
//  Copyright © 2018 Garrett Votaw. All rights reserved.
//

import UIKit

class GenreTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var selectorButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func selectedButton() {
        if selectorButton.image(for: .normal) == #imageLiteral(resourceName: "selectedButton") {
            selectorButton.setImage(#imageLiteral(resourceName: "unselectedButton"), for: .normal)
        } else {
            selectorButton.setImage(#imageLiteral(resourceName: "selectedButton"), for: .normal)
        }
        
    }
    
}

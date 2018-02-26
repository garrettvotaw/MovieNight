//
//  ActorTableViewCell.swift
//  Movie Night
//
//  Created by Garrett Votaw on 1/31/18.
//  Copyright © 2018 Garrett Votaw. All rights reserved.
//

import UIKit

class ActorTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var associatedMoviesLabel: UILabel!
    @IBOutlet weak var selectorButton: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            selectorButton.image = #imageLiteral(resourceName: "selectedButton")
        } else {
            selectorButton.image = #imageLiteral(resourceName: "unselectedButton")
        }
        // Configure the view for the selected state
    }
}

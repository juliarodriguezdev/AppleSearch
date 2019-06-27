//
//  AppleItemTableViewCell.swift
//  AppleSearch
//
//  Created by Julia Rodriguez on 6/27/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class AppleItemTableViewCell: UITableViewCell {

    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var trackLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var albumLabel: UILabel!
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

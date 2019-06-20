//
//  DraggerTableViewCell.swift
//  Les_13_CocoaPods_Animation
//
//  Created by Tetiana Hranchenko on 6/20/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import UIKit

class DraggerTableViewCell: UITableViewCell {

    @IBOutlet weak var draggerImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
         backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

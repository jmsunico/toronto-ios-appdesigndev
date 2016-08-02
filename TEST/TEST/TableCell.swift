//
//  TableCell.swift
//  TEST
//
//  Created by José-María Súnico on 20160801.
//  Copyright © 2016 José-María Súnico. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {

	
	@IBOutlet weak var myImage: UIImageView!
	@IBOutlet weak var label: UILabel!

	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

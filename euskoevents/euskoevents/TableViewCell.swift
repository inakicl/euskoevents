//
//  TableViewCell.swift
//  euskoevents
//
//  Created by iñaki on 19/12/17.
//  Copyright © 2017 iñaki. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    let texto = "prueba"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var label: UILabel!
    
}

//
//  AdressResultTableViewCell.swift
//  Conviva
//
//  Created by Joyce Simão Clímaco on 29/11/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import Foundation
import UIKit

class AdressSearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.titleLabel.font = UIFont(name: "Roboto", size: 18)
        self.detailLabel.font = UIFont(name: "Roboto", size: 12)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

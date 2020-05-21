//
//  ProtocolTableViewCell.swift
//  AppUser
//
//  Created by Gabriel Ferreira on 22/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit

class ProtocolTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupAccessibility()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupAccessibility() {
        let nameFont = UIFont(name: "SFProDisplay-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17)

        self.nameLabel.dynamicFont = nameFont
    }
    
}

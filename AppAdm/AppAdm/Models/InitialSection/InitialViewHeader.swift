//
//  InitialViewHeader.swift
//  AppUser
//
//  Created by Gabriel Ferreira on 29/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit

class InitialViewHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var initialLabel: UILabel!
    
    override func awakeFromNib() {
         super.awakeFromNib()
         
         self.setupAccessibility()
     }

    private func setupAccessibility() {
        let font = UIFont(name: "SFProDisplay-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17)
        
        self.initialLabel.dynamicFont = font
    }

}

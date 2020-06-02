//
//  TituloEtapaViewCell.swift
//  AppUser
//
//  Created by Luma Gabino Vasconcelos on 24/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit

class TituloEtapaViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupAccessibility()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupAccessibility() {
        let titleFont = UIFont(name: "SFProDisplay-Regular", size: 18) ?? UIFont.systemFont(ofSize: 18)

        self.titleLabel.dynamicFont = titleFont
    }
    @IBAction func editTitle(_ sender: Any) {
        print("Edit clicked")
    }
}

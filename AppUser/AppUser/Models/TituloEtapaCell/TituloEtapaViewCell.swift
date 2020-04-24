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
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var lineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

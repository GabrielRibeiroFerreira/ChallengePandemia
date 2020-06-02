//
//  SearchViewHeader.swift
//  AppUser
//
//  Created by Gabriel Ferreira on 29/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SearchViewHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var addRoomButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupAccessibility()
    }
    
    private func setupAccessibility() {
        let roomFont = UIFont(name: "SFProDisplay-Bold", size: 24) ?? UIFont.systemFont(ofSize: 24)
        
        self.roomLabel.dynamicFont = roomFont
    }
}

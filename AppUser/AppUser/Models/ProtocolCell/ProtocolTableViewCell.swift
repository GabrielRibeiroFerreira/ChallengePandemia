//
//  ProtocolTableViewCell.swift
//  AppUser
//
//  Created by Gabriel Ferreira on 22/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit

protocol ProtocolCellDelegate {
    func didTapEditCell(_ cell: ProtocolTableViewCell)
    func didTapDeleteCell(_ cell: ProtocolTableViewCell)
}

class ProtocolTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var arrowButoon: UIButton!
    var delegate: ProtocolCellDelegate?
    
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
    
    func getIndexPath() -> IndexPath? {
        guard let superView = self.superview as? UITableView else {
            print("superview is not a UITableView - getIndexPath")
            return nil
        }
        let indexPath = superView.indexPath(for: self)
        return indexPath
    }
    
    @IBAction func editCell(_ sender: Any) {
        delegate?.didTapEditCell(self)
    }
    
    @IBAction func deleteCell(_ sender: Any) {
        delegate?.didTapDeleteCell(self)
    }
}

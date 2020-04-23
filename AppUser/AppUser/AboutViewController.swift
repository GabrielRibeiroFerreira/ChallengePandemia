//
//  AboutViewController.swift
//  AppUser
//
//  Created by Luma Gabino Vasconcelos on 22/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var firstDescripLabel: UILabel!
    @IBOutlet weak var secondDescripLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    let appBlueColor = UIColor(named: "appBlue")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupAccessibility()
    }
    
    private func setupAccessibility() {
        let firstFont = UIFont(name: "SFProDisplay", size: 18) ?? UIFont.systemFont(ofSize: 18)
        let secondFont = UIFont(name: "SFProDisplay-Bold", size: 18) ?? UIFont.systemFont(ofSize: 18)
        let contactFont = UIFont(name: "SFProDisplay-Bold", size: 24) ?? UIFont.systemFont(ofSize: 24)
        let emailFont = UIFont(name: "SFProDisplay", size: 18) ?? UIFont.systemFont(ofSize: 18)

        self.firstDescripLabel.dynamicFont = firstFont
        self.secondDescripLabel.dynamicFont = secondFont
        self.contactLabel.dynamicFont = contactFont
        self.emailLabel.dynamicFont = emailFont
    }
    
}

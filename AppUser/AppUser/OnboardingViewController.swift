//
//  OnboardingViewController.swift
//  AppUser
//
//  Created by Luma Gabino Vasconcelos on 20/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet weak var forYouLabel: UILabel!
    @IBOutlet weak var professionalLabel: UILabel!
    @IBOutlet weak var agilityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Underline na palavra Profissional
        self.professionalLabel.attributedText = NSAttributedString(string: "Profissional", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        
        self.setupAccessibility()
    }
    
    private func setupAccessibility() {
        let forYouFont = UIFont(name: "SFProDisplay-Bold", size: 28) ?? UIFont.systemFont(ofSize: 28)
        let professionalFont = UIFont(name: "SFProDisplay-Bold", size: 28) ?? UIFont.systemFont(ofSize: 28)
        let agilityFont = UIFont(name: "SFProDisplay-Bold", size: 37) ?? UIFont.systemFont(ofSize: 37)
        let descriptionFont = UIFont(name: "SFProDisplay-Medium", size: 18) ?? UIFont.systemFont(ofSize: 18)

        self.forYouLabel.dynamicFont = forYouFont
        self.professionalLabel.dynamicFont = professionalFont
        self.agilityLabel.dynamicFont = agilityFont
        self.descriptionLabel.dynamicFont = descriptionFont
    }
    
}

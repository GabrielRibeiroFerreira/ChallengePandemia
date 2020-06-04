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
    @IBOutlet weak var enterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Underline na palavra Profissional
        self.professionalLabel.attributedText = NSAttributedString(string: "de Trabalho", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        
        //Bordas do botão arredondadas
        self.enterButton.layer.cornerRadius = 16.0
        
        self.setupAccessibility()
        
    }

    
    private func setupAccessibility() {
        let forYouFont = UIFont(name: "SFProDisplay-Bold", size: 28) ?? UIFont.systemFont(ofSize: 28)
        let agilityFont = UIFont(name: "SFProDisplay-Bold", size: 37) ?? UIFont.systemFont(ofSize: 37)
        let descriptionFont = UIFont(name: "SFProDisplay-Medium", size: 18) ?? UIFont.systemFont(ofSize: 18)
        let buttonFont = UIFont(name: "SFProDisplay-Bold", size: 24) ?? UIFont.systemFont(ofSize: 24)


        self.forYouLabel.dynamicFont = forYouFont
        self.professionalLabel.dynamicFont = forYouFont
        self.agilityLabel.dynamicFont = agilityFont
        self.descriptionLabel.dynamicFont = descriptionFont
        self.enterButton.titleLabel?.dynamicFont = buttonFont
        
        //Restringindo tamanho da fonte para dynamic type
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        self.forYouLabel.font = fontMetrics.scaledFont(for: forYouFont, maximumPointSize: 60.0)
        self.professionalLabel.font = fontMetrics.scaledFont(for: forYouFont, maximumPointSize: 60.0)

    }
    
}

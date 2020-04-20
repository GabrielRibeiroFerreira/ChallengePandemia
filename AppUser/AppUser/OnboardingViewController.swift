//
//  OnboardingViewController.swift
//  AppUser
//
//  Created by Luma Gabino Vasconcelos on 20/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet weak var professionalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.professionalLabel.attributedText = NSAttributedString(string: "Profissional", attributes:
        [.underlineStyle: NSUnderlineStyle.single.rawValue])
        
        
    }
    
}

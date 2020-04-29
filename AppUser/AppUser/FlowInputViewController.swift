//
//  FluxoInputViewController.swift
//  AppUser
//
//  Created by Inara Takashi on 24/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit

class FlowInputViewController: UIViewController {

  
    @IBOutlet weak var titleContent: UILabel!
    @IBOutlet weak var subtitleContent: UILabel!   
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor(named: "appColor")
        navigationController?.navigationBar.isTranslucent = false
        setupAccessibility()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor(named: "appColor")
    }
    
    private func setupAccessibility() {
        let titleContentFont = UIFont(name: "SFProDisplay-Bold", size: 24) ?? UIFont.systemFont(ofSize: 24)
        let subtitleContentFont = UIFont(name: "SFProDisplay-Bold", size: 36) ?? UIFont.systemFont(ofSize: 36)
        let contentFont = UIFont(name: "SFProDisplay-Regular", size: 19) ?? UIFont.systemFont(ofSize: 19)
        let buttonFont = UIFont(name: "SFProDisplay-Regular", size: 22) ?? UIFont.systemFont(ofSize: 22)
        
        self.titleContent.dynamicFont = titleContentFont
        self.subtitleContent.dynamicFont = subtitleContentFont
        self.content.dynamicFont = contentFont
        self.yesBtn.titleLabel?.dynamicFont = buttonFont
        self.noBtn.titleLabel?.dynamicFont = buttonFont
        
    }

}

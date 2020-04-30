//
//  FlowExtensiveContentViewController.swift
//  AppUser
//
//  Created by Inara Takashi on 24/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit

class FlowExtensiveContentViewController: UIViewController {
    @IBOutlet weak var titleContent: UILabel!
    @IBOutlet weak var subtitleContent: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var progressBtn: UIButton!
    
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
        let titleFont = UIFont(name: "SFProDisplay-Bold", size: 24) ?? UIFont.systemFont(ofSize: 24)
        let subtitleFont = UIFont(name: "SFProDisplay-Bold", size: 19) ?? UIFont.systemFont(ofSize: 19)
        let contentFont = UIFont(name: "SFProDisplay-Regular", size: 19) ?? UIFont.systemFont(ofSize: 19)
        let btnFont = UIFont(name: "SFProDisplay-Regular", size: 22) ?? UIFont.systemFont(ofSize: 22)
        
        self.titleContent.dynamicFont = titleFont
        self.subtitleContent.dynamicFont = subtitleFont
        self.content.dynamicFont = contentFont
        self.progressBtn.titleLabel?.dynamicFont = btnFont
        
    }

}

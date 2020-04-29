//
//  FlowFinalViewController.swift
//  AppUser
//
//  Created by Inara Takashi on 25/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit

class FlowFinalViewController: UIViewController {

    @IBOutlet weak var titleContent: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var finishBtn: UIButton!
    
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
        let contentFont = UIFont(name: "SFProDisplay-Bold", size: 24) ?? UIFont.systemFont(ofSize: 24)
        let btnFont = UIFont(name: "SFProDisplay-Regular", size: 22) ?? UIFont.systemFont(ofSize: 22)
            
        self.titleContent.dynamicFont = titleFont
        self.content.dynamicFont = contentFont
        self.finishBtn.titleLabel?.dynamicFont = btnFont
            
        }


}

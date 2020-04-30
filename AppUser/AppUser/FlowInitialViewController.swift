//
//  FluxoInicialViewController.swift
//  AppUser
//
//  Created by Inara Takashi on 22/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit

class FlowInitialViewController: UIViewController {
    
    @IBOutlet weak var titleInitial: UILabel!
    
    @IBOutlet weak var textInitial: UILabel!

    @IBOutlet weak var progressBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor(named: "appBlue")
        navigationController?.navigationBar.isTranslucent = false
        setupAccessibility()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor(named: "appBlue")
    }
    
    
    private func setupAccessibility() {
        let titleInitialFont = UIFont(name: "SFProDisplay-Bold", size: 24) ?? UIFont.systemFont(ofSize: 24)
        let textInitialFont = UIFont(name: "SFProDisplay-Bold", size: 36) ?? UIFont.systemFont(ofSize: 36)
        let btnFont = UIFont(name: "SFProDisplay-Regular", size: 22) ?? UIFont.systemFont(ofSize: 22)
        
        self.titleInitial.dynamicFont = titleInitialFont
        self.textInitial.dynamicFont = textInitialFont
        self.progressBtn.titleLabel?.dynamicFont = btnFont
        
    }

}

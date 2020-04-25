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
    
    
    func setAccessibility(){
        self.titleInitial.isAccessibilityElement = true
        self.textInitial.isAccessibilityElement = true
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(named: "appBlue")
        setAccessibility()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor(named: "appBlue")
    }
    
    
    

}

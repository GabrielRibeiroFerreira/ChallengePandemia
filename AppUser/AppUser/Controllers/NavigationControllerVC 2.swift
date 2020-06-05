//
//  NavigationControllerViewController.swift
//  AppUser
//
//  Created by Luma Gabino Vasconcelos on 24/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit

class NavigationControllerVC: UINavigationController {
    @IBOutlet weak var navBar: UINavigationBar!
    let appBlue = UIColor(named: "appBlue")
    let appColor = UIColor(named: "appColor")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavBar()
    }
    
    func setUpNavBar() {
        self.navBar.prefersLargeTitles = true
        self.navBar.largeTitleTextAttributes = [.foregroundColor: self.appBlue ?? UIColor.blue]        
    }

}

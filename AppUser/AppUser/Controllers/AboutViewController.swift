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
    @IBOutlet weak var contact2Label: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var numberVersionLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupAccessibility()
        self.setupNavBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNavBar()
    }
    
    
    
    func setupNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.title = "Sobre"
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "appContrast")
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "appContrast") ?? UIColor.blue
        self.navigationController?.navigationBar.tintColor = UIColor(named: "appBlue")
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "appBlue") ?? UIColor.white]
    }
    
    private func setupAccessibility() {
        let commonFont = UIFont(name: "SFProDisplay", size: 18) ?? UIFont.systemFont(ofSize: 18)
        let secondFont = UIFont(name: "SFProDisplay-Bold", size: 18) ?? UIFont.systemFont(ofSize: 18)

        self.firstDescripLabel.dynamicFont = commonFont
        self.secondDescripLabel.dynamicFont = secondFont
        self.contactLabel.dynamicFont = commonFont
        self.contact2Label.dynamicFont = secondFont
        self.versionLabel.dynamicFont = commonFont
        self.emailLabel.dynamicFont = commonFont
        self.numberVersionLabel.dynamicFont = commonFont
    }
    
}

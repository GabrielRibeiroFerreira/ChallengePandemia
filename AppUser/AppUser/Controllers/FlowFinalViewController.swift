//
//  FlowFinalViewController.swift
//  AppUser
//
//  Created by Inara Takashi on 25/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FlowFinalViewController: UIViewController {

    @IBOutlet weak var titleContent: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var finishBtn: UIButton!
    
    var bdRefFlow: String = ""
    var bdRefStep: String = ""
    
    let refFlow = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupAccessibility()
        self.setupNavBar()
        self.getDataFromDB()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.setupNavBar()
    }
    
    func setupNavBar() {
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "appColor")
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "appColor")
        self.navigationController?.navigationBar.tintColor = UIColor(named: "appBlue")
    }
        
    private func setupAccessibility() {
        let titleFont = UIFont(name: "SFProDisplay-Bold", size: 24) ?? UIFont.systemFont(ofSize: 24)
        let contentFont = UIFont(name: "SFProDisplay-Bold", size: 24) ?? UIFont.systemFont(ofSize: 24)
        let btnFont = UIFont(name: "SFProDisplay-Regular", size: 22) ?? UIFont.systemFont(ofSize: 22)
            
        self.titleContent.dynamicFont = titleFont
        self.content.dynamicFont = contentFont
        self.finishBtn.titleLabel?.dynamicFont = btnFont
            
        }
    
    func getDataFromDB() {
        //Recuperação Fluxos
        let urlFlowAtual = "Fluxos/" + self.bdRefFlow + "/Etapas/" + self.bdRefStep
        
        self.refFlow.child(urlFlowAtual + "/titulo").observeSingleEvent(of: .value) { (snapshot) in
            self.titleContent.text =  snapshot.value as? String
        }

        self.refFlow.child(urlFlowAtual + "/descricao").observeSingleEvent(of: .value) { (snapshot) in
            self.content.text =  snapshot.value as? String
        }
        
    }


}

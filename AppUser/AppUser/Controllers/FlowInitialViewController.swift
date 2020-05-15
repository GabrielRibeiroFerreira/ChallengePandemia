//
//  FluxoInicialViewController.swift
//  AppUser
//
//  Created by Inara Takashi on 22/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FlowInitialViewController: UIViewController {
    
    @IBOutlet weak var titleInitial: UILabel!
    
    @IBOutlet weak var textInitial: UILabel!

    @IBOutlet weak var progressBtn: UIButton!
    
    var bdRefFlow: String = "idFluxo1"
    var bdRefStep: String = "idEtapa1"
    var idScreen: String = ""
    var typeProx: String = ""
    var segueInitial: String = ""
    
    let refFlow = Database.database().reference()
    let dispatchGroup1 = DispatchGroup()
    let dispatchGroup2 = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNavBar()
        self.setupAccessibility()
        self.getDataFromDB()

        self.dispatchGroup2.notify(queue: .main) {
            if self.typeProx == "alternativa"{
                self.segueInitial = "segueInitialInput"
            }else if self.typeProx == "avancarCurto"{
                self.segueInitial = "segueInitialShort"
            }else if self.typeProx == "avancarExtenso"{
                self.segueInitial = "segueInitialExtensive"
            }else if self.typeProx == "final"{
                self.segueInitial = "segueInitialFinal"
            }
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.setupNavBar()
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "appBlue")
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "appBlue")
        self.navigationController?.navigationBar.tintColor = UIColor(named: "appColor")
        self.navigationController?.navigationBar.isTranslucent = false
     }
     
    private func setupAccessibility() {
        let titleInitialFont = UIFont(name: "SFProDisplay-Bold", size: 24) ?? UIFont.systemFont(ofSize: 24)
        let textInitialFont = UIFont(name: "SFProDisplay-Bold", size: 36) ?? UIFont.systemFont(ofSize: 36)
        let btnFont = UIFont(name: "SFProDisplay-Regular", size: 22) ?? UIFont.systemFont(ofSize: 22)
        
        self.titleInitial.dynamicFont = titleInitialFont
        self.textInitial.dynamicFont = textInitialFont
        self.progressBtn.titleLabel?.dynamicFont = btnFont
        
    }
    
    func getDataFromDB() {
        //Recuperação da Etapa
        let urlFlowAtual = "Fluxos/" + self.bdRefFlow + "/Etapas/" + self.bdRefStep
        let urlFlowProx = "Fluxos/" + self.bdRefFlow + "/Etapas/"
        
        self.dispatchGroup1.enter()
        self.refFlow.child(urlFlowAtual + "/titulo").observeSingleEvent(of: .value) { (snapshot) in
            self.titleInitial.text =  snapshot.value as? String
        }

        self.refFlow.child(urlFlowAtual + "/descricao").observeSingleEvent(of: .value) { (snapshot) in
            self.textInitial.text =  snapshot.value as? String
        }
        
        self.refFlow.child(urlFlowAtual + "/id_nao").observeSingleEvent(of: .value) { (snapshot) in
            self.idScreen =  snapshot.value as! String
            self.dispatchGroup1.leave()
        }
        
        self.dispatchGroup2.enter()
        self.dispatchGroup1.notify(queue: .main) {
            self.refFlow.child(urlFlowProx + self.idScreen + "/tipo").observeSingleEvent(of: .value) { (snapshot) in
                if (snapshot.exists()){
                    self.typeProx = snapshot.value as! String
                    self.dispatchGroup2.leave()
                }else{
                    print("Error: Id Next Screen Not Found")
                }
            }
        }
    }
    
    @IBAction func btnProgress(_ sender: Any) {
        if segueInitial != ""{
            performSegue(withIdentifier: segueInitial, sender: self)
        }else{
            print("Error: Segue Not Found")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueInitialInput"{
            if let id = segue.destination as? FlowInputViewController {
                id.bdRefFlow = bdRefFlow //passa o id do fluxo para a proxima tela
                id.bdRefStep = idScreen //passa o id da etapa para a proxima tela
            }
        }else if segue.identifier == "segueInitialShort"{
            if let id = segue.destination as? FlowShortContentViewController {
                id.bdRefFlow = bdRefFlow
                id.bdRefStep = idScreen
            }
        }else if segue.identifier == "segueInitialExtensive"{
            if let id = segue.destination as? FlowExtensiveContentViewController {
                id.bdRefFlow = bdRefFlow
                id.bdRefStep = idScreen
            }
        }else if segue.identifier == "segueInitialFinal"{
            if let id = segue.destination as? FlowFinalViewController {
                id.bdRefFlow = bdRefFlow
                id.bdRefStep = idScreen
            }
        }
    }
}

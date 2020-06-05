//
//  FlowShortContentViewController.swift
//  AppUser
//
//  Created by Inara Takashi on 24/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FlowShortContentViewController: UIViewController {

    @IBOutlet weak var titleContent: UILabel!
    @IBOutlet weak var subtitleContent: UILabel!
    @IBOutlet weak var progressBtn: UIButton!
    
    var bdRefFlow: String = ""
    var bdRefStep: String = ""
    var idScreen: String = ""
    var typeProx: String = ""
    var segueShort: String = ""
    
    let refFlow = Database.database().reference()
    let dispatchGroup1 = DispatchGroup()
    let dispatchGroup2 = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupAccessibility()
        self.setupNavBar()
        self.getDataFromDB()
        
        self.dispatchGroup2.notify(queue: .main) {
            if self.typeProx == "alternativa"{
                self.segueShort = "segueShortInput"
            }else if self.typeProx == "avancarCurto"{
                self.segueShort = "segueShortShort"
            }else if self.typeProx == "avancarExtenso"{
                self.segueShort = "segueShortExtensive"
            }else if self.typeProx == "final"{
                self.segueShort = "segueShortFinal"
            }
        }
        
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
        let titleFont = UIFont(name: "SFProDisplay-Bold", size: 22) ?? UIFont.systemFont(ofSize: 22)
        let subtitleFont = UIFont(name: "SFProDisplay-Bold", size: 26) ?? UIFont.systemFont(ofSize: 26)
        let btnFont = UIFont(name: "SFProDisplay-Medium", size: 24) ?? UIFont.systemFont(ofSize: 24)
        
        self.titleContent.dynamicFont = titleFont
        self.subtitleContent.dynamicFont = subtitleFont
        self.progressBtn.titleLabel?.dynamicFont = btnFont
        
    }
    
    func getDataFromDB() {
        //Recuperação da Etapa
        let urlFlowAtual = "Fluxos/" + self.bdRefFlow + "/" + self.bdRefStep
        let urlFlowProx = "Fluxos/" + self.bdRefFlow + "/"
        
        
        self.refFlow.child(urlFlowAtual + "/titulo").observeSingleEvent(of: .value) { (snapshot) in
            self.titleContent.text = snapshot.value as? String
        }

        self.refFlow.child(urlFlowAtual + "/descricao").observeSingleEvent(of: .value) { (snapshot) in
            self.subtitleContent.text =  snapshot.value as? String
        }
        
        self.dispatchGroup1.enter()
        self.refFlow.child(urlFlowAtual + "/id_nao").observeSingleEvent(of: .value) { (snapshot) in
            self.idScreen = snapshot.value as! String
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
        if segueShort != ""{
            performSegue(withIdentifier: segueShort, sender: self)
        }else{
            print("Error: Segue Not Found")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueShortInput"{
            if let id = segue.destination as? FlowInputViewController {
                id.bdRefFlow = bdRefFlow //passa o id do fluxo para a proxima tela
                id.bdRefStep = idScreen //passa o id da etapa para a proxima tela
            }
        }else if segue.identifier == "segueShortShort"{
            if let id = segue.destination as? FlowShortContentViewController {
                id.bdRefFlow = bdRefFlow
                id.bdRefStep = idScreen
            }
        }else if segue.identifier == "segueShortExtensive"{
            if let id = segue.destination as? FlowExtensiveContentViewController {
                id.bdRefFlow = bdRefFlow
                id.bdRefStep = idScreen
            }
        }else if segue.identifier == "segueShortFinal"{
            if let id = segue.destination as? FlowFinalViewController {
                id.bdRefFlow = bdRefFlow
                id.bdRefStep = idScreen
            }
        }else if segue.identifier == "toStageSegue"{
            if let etapas = segue.destination as? EtapasViewController {
                etapas.markedStage = self.bdRefStep
                etapas.flow = self.bdRefFlow
            }
        }
    }
}

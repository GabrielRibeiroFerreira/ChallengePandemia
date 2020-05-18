//
//  FluxoInputViewController.swift
//  AppUser
//
//  Created by Inara Takashi on 24/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FlowInputViewController: UIViewController {

  
    @IBOutlet weak var titleContent: UILabel!
    @IBOutlet weak var subtitleContent: UILabel!   
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    
    var bdRefFlow: String = ""
    var bdRefStep: String = ""
    var idScreenYes: String = ""
    var idScreenNo: String = ""
    var typeProxYes: String = ""
    var typeProxNo: String = ""
    var segueInputYes: String = ""
    var segueInputNo: String = ""
    var isYes = true
    
    let refFlow = Database.database().reference()
    let dispatchGroup1 = DispatchGroup()
    let dispatchGroup2 = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavBar()
        self.setupAccessibility()
        self.getDataFromDB()
        
        self.dispatchGroup2.notify(queue: .main) {
            if self.typeProxYes == "alternativa"{
                self.segueInputYes = "segueInputInput"
            }else if self.typeProxYes == "avancarCurto"{
                self.segueInputYes = "segueInputShort"
            }else if self.typeProxYes == "avancarExtenso"{
                self.segueInputYes = "segueInputExtensive"
            }else if self.typeProxYes == "final"{
                self.segueInputYes = "segueInputFinal"
            }
            if self.typeProxNo == "alternativa"{
                self.segueInputNo = "segueInputInput"
            }else if self.typeProxNo == "avancarCurto"{
                self.segueInputNo = "segueInputShort"
            }else if self.typeProxNo == "avancarExtenso"{
                self.segueInputNo = "segueInputExtensive"
            }else if self.typeProxNo == "final"{
                self.segueInputNo = "segueInputFinal"
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
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "appColor")
        self.navigationController?.navigationBar.tintColor = UIColor(named: "appBlue")
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
    
    func getDataFromDB() {
        //Recuperação da Etapa
        let urlFlowAtual = "Fluxos/" + self.bdRefFlow + "/Etapas/" + self.bdRefStep
        let urlFlowProx = "Fluxos/" + self.bdRefFlow + "/Etapas/"
        
        
        self.refFlow.child(urlFlowAtual + "/titulo").observeSingleEvent(of: .value) { (snapshot) in
            self.titleContent.text =  snapshot.value as? String
        }
        
        self.refFlow.child(urlFlowAtual + "/subtitulo").observeSingleEvent(of: .value) { (snapshot) in
            self.subtitleContent.text =  snapshot.value as? String
        }

        self.refFlow.child(urlFlowAtual + "/descricao").observeSingleEvent(of: .value) { (snapshot) in
            self.content.text =  snapshot.value as? String
        }
        
        self.dispatchGroup1.enter()
        self.refFlow.child(urlFlowAtual + "/id_nao").observeSingleEvent(of: .value) { (snapshot) in
            self.idScreenNo =  snapshot.value as! String
            self.dispatchGroup1.leave()
        }
        
        self.dispatchGroup1.enter()
        self.refFlow.child(urlFlowAtual + "/id_sim").observeSingleEvent(of: .value) { (snapshot) in
            self.idScreenYes =  snapshot.value as! String
            self.dispatchGroup1.leave()
        }
        
        self.dispatchGroup2.enter()
        self.dispatchGroup1.notify(queue: .main) {
            self.refFlow.child(urlFlowProx + self.idScreenYes + "/tipo").observeSingleEvent(of: .value) { (snapshot) in
                if (snapshot.exists()){
                    self.typeProxYes = snapshot.value as! String
                    self.dispatchGroup2.leave()
                }else{
                    print("Error: Id Next Screen Not Found")
                }
            }
            
            self.dispatchGroup2.enter()
            self.refFlow.child(urlFlowProx + self.idScreenNo + "/tipo").observeSingleEvent(of: .value) { (snapshot) in
                if (snapshot.exists()){
                    self.typeProxNo = snapshot.value as! String
                    self.dispatchGroup2.leave()
                }else{
                    print("Error: Id Next Screen Not Found")
                }
            }
        }
    }

    @IBAction func btnNo(_ sender: Any) {
        self.isYes = false
        if segueInputNo != ""{
            performSegue(withIdentifier: segueInputNo, sender: self)
        }else{
            print("Error: Segue Not Found")
        }
    }
    
    @IBAction func btnYes(_ sender: Any) {
        self.isYes = true
        if segueInputYes != ""{
           performSegue(withIdentifier: segueInputYes, sender: self)
        }else{
            print("Error: Segue Not Found")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueInputInput"{
            if let id = segue.destination as? FlowInputViewController {
                id.bdRefFlow = bdRefFlow //passa o id do fluxo para a proxima tela
                if isYes == true{
                    id.bdRefStep = idScreenYes //passa o id da etapa para a proxima tela
                }else{
                    id.bdRefStep = idScreenNo //passa o id da etapa para a proxima tela
                }
            }
        }else if segue.identifier == "segueInputShort"{
            if let id = segue.destination as? FlowShortContentViewController {
                id.bdRefFlow = bdRefFlow
                if isYes == true{
                    id.bdRefStep = idScreenYes
                }else{
                    id.bdRefStep = idScreenNo
                }
            }
        }else if segue.identifier == "segueInputExtensive"{
            if let id = segue.destination as? FlowExtensiveContentViewController {
                id.bdRefFlow = bdRefFlow
                if isYes == true{
                    id.bdRefStep = idScreenYes
                }else{
                    id.bdRefStep = idScreenNo
                }
            }
        }else if segue.identifier == "segueInputFinal"{
            if let id = segue.destination as? FlowFinalViewController {
                id.bdRefFlow = bdRefFlow
                if isYes == true{
                    id.bdRefStep = idScreenYes
                }else{
                    id.bdRefStep = idScreenNo
                }
            }
        }else if segue.identifier == "toStageSegue"{
            if let etapas = segue.destination as? EtapasViewController {
                etapas.markedStage = self.bdRefStep
                etapas.flow = self.bdRefFlow
            }
        }
    }
}

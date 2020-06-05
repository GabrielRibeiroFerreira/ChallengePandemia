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


    @IBOutlet weak var titleFlow: UILabel!
    @IBOutlet weak var titleContent: UILabel!
    @IBOutlet weak var contentInput: UITextField!
    @IBOutlet weak var titleContent2: UILabel!
    @IBOutlet weak var contentInput2: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var bdRefFlow: String = ""
    var bdRefStep: String = ""
    var isYes = true
    var isAlternative = true
    var typeStep = "alternativa"
    var titleFlowBD = ""
    var segueInput = "segueAlternative"
    var timeStampStep = ""
    var findFirstAlternative: Bool?
    var index = 0
    
    var viewControllers: [UIViewController]?
    
    let refFlow = Database.database().reference()
    let dispatchGroup1 = DispatchGroup()
    let dispatchGroup2 = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.HideKeyboard()
        self.DismissKeyboard()
        self.setupTextField()
        
        let urlFlowAtual = "Fluxos/" + self.bdRefFlow + "/" + self.bdRefStep
        self.refFlow.child(urlFlowAtual + "/titulo").observeSingleEvent(of: .value) { (snapshot) in
            self.titleFlow.text = (snapshot.value as? String)!
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
        
    }
    
    func setupTextField() {
        let titleFont = UIFont(name: "SFProDisplay-Bold", size: 24)
        contentInput.font = titleFont
        contentInput.attributedPlaceholder = NSAttributedString(string: "Digite o nome do fluxo", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "appBlue")!])
        contentInput2.attributedPlaceholder = NSAttributedString(string: "Digite a introdução do fluxo", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "appContrast")!])
    }
    
    @IBAction func indexChange(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            titleContent.isHidden = false
            contentInput.isHidden = false
            titleContent2.isHidden = false
            contentInput2.isHidden = false
            contentInput.text?.removeAll()
            contentInput2.text?.removeAll()
            titleContent.text = "Pergunta da Decisão"
            titleContent2.text = "Texto da Decisão"
            let titleFont = UIFont(name: "SFProDisplay-Bold", size: 24)
            contentInput.font = titleFont
            contentInput.textColor = UIColor(named: "appBlue")
            contentInput.attributedPlaceholder = NSAttributedString(string: "Digite o nome do fluxo", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "appBlue")!])
            contentInput2.attributedPlaceholder = NSAttributedString(string: "Digite a introdução do fluxo", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "appContrast")!])
            typeStep = "alternativa"
            segueInput = "segueAlternative"
        case 1:
            titleContent.isHidden = false
            contentInput.isHidden = false
            titleContent2.isHidden = false
            contentInput2.isHidden = false
            contentInput.text?.removeAll()
            contentInput2.text?.removeAll()
            titleContent.text = "Subtítulo da Etapa"
            titleContent2.text = "Conteúdo da Etapa"
            let titleFont = UIFont(name: "SFProDisplay-Bold", size: 19)
            contentInput.font = titleFont
            contentInput.textColor = UIColor(named: "appContrast")
            contentInput.attributedPlaceholder = NSAttributedString(string: "Digite o subtítulo da etapa", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "appContrast")!])
            contentInput2.attributedPlaceholder = NSAttributedString(string: "Digite o conteúdo da etapa que será apresentado", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "appContrast")!])
            typeStep = "avancarExtenso"
            segueInput = "segueCreate"
        case 2:
            titleContent.isHidden = false
            contentInput.isHidden = false
            titleContent2.isHidden = true
            contentInput2.isHidden = true
            contentInput.text?.removeAll()
            contentInput2.text?.removeAll()
            titleContent.text = "Notificação"
            let titleFont = UIFont(name: "SFProDisplay-Bold", size: 24)
            contentInput.font = titleFont
            contentInput.textColor = UIColor(named: "appContrast")
            contentInput.attributedPlaceholder = NSAttributedString(string: "Digite a notificação da etapa", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "appContrast")!])
            typeStep = "avancarCurto"
            segueInput = "segueCreate"
        case 3:
            titleContent.isHidden = false
            contentInput.isHidden = false
            titleContent2.isHidden = true
            contentInput2.isHidden = true
            contentInput.text?.removeAll()
            contentInput2.text?.removeAll()
            titleContent.text = "Notificação Final"
            let titleFont = UIFont(name: "SFProDisplay-Bold", size: 24)
            contentInput.font = titleFont
            contentInput.textColor = UIColor(named: "appContrast")
            contentInput.attributedPlaceholder = NSAttributedString(string: "Digite a notificação final", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "appContrast")!])
            typeStep = "final"
            segueInput = "segueEtapas"
        default:
            break;
        }
    }
    
    @IBAction func btnProgress(_ sender: Any) {
        
        self.timeStampStep = "\(Int(NSDate.timeIntervalSinceReferenceDate*1000))"
        
        self.dispatchGroup1.enter()
        let urlFlowAtual = "Fluxos/" + self.bdRefFlow + "/" + self.bdRefStep
        self.refFlow.child(urlFlowAtual + "/titulo").observeSingleEvent(of: .value) { (snapshot) in
            self.titleFlowBD = (snapshot.value as? String)!
            self.titleFlow.text = (snapshot.value as? String)!
            self.dispatchGroup1.leave()
        }
        
        self.dispatchGroup1.notify(queue: .main){
            self.refFlow.child("Fluxos/\(self.bdRefFlow)/\(self.timeStampStep)/titulo").setValue(self.titleFlowBD)
            self.refFlow.child("Fluxos/\(self.bdRefFlow)/\(self.timeStampStep)/subtitulo").setValue(self.contentInput.text)
            self.refFlow.child("Fluxos/\(self.bdRefFlow)/\(self.timeStampStep)/descricao").setValue(self.contentInput2.text)
            self.refFlow.child("Fluxos/\(self.bdRefFlow)/\(self.timeStampStep)/idEtapa").setValue(self.timeStampStep)
            self.refFlow.child("Fluxos/\(self.bdRefFlow)/\(self.timeStampStep)/tipo").setValue("\(self.typeStep)")
            
            //Salvando id dessa etapa na etapa anterior
            if self.isAlternative == true{
                if self.isYes == true{
                   self.refFlow.child("Fluxos/\(self.bdRefFlow)/\(self.bdRefStep)/id_sim").setValue(self.timeStampStep)
                }else{
                    self.refFlow.child("Fluxos/\(self.bdRefFlow)/\(self.bdRefStep)/id_nao").setValue(self.timeStampStep)
                }
            }else{
                self.refFlow.child("Fluxos/\(self.bdRefFlow)/\(self.bdRefStep)/id_sim").setValue(self.timeStampStep)
                self.refFlow.child("Fluxos/\(self.bdRefFlow)/\(self.bdRefStep)/id_nao").setValue(self.timeStampStep)
            }
            
            if self.typeStep == "final"{
                self.updateNavigation()
                self.refFlow.child("Fluxos/\(self.bdRefFlow)/\(self.timeStampStep)/id_nao").setValue("idEtapa0")
                self.refFlow.child("Fluxos/\(self.bdRefFlow)/\(self.timeStampStep)/id_sim").setValue("idEtapa0")
            }else{
                let alert = UIAlertController(title: "Título da Etapa", message: "Digite abaixo qual será o título para esta etapa.", preferredStyle: .alert)
                
                alert.addTextField { (textField) in
                    textField.placeholder = "Título Resumido"
                    textField.isSecureTextEntry = false
                }
                
                alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: {(action) in
                    self.refFlow.child("Fluxos/\(self.bdRefFlow)/\(self.timeStampStep)/tituloResumido").setValue(alert.textFields![0].text)
                    self.performSegue(withIdentifier: self.segueInput, sender: self)
                }))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueCreate"{
            if let id = segue.destination as? FlowInputViewController {
                id.bdRefFlow = bdRefFlow //passa o id do fluxo para a proxima tela
                id.bdRefStep = "\(self.timeStampStep)" //passa o id da etapa para a proxima tela
                id.isAlternative = false
            }
        }else if segue.identifier == "segueAlternative"{
            if let id = segue.destination as? FlowExtensiveContentViewController {
                id.bdRefFlow = bdRefFlow
                id.bdRefStep = "\(self.timeStampStep)"
            }
        }else if segue.identifier == "segueEtapas"{
            if let id = segue.destination as? EtapasViewController {
                self.refFlow.child("Fluxos/\(self.bdRefFlow)/\(self.timeStampStep)/id_nao").setValue("idEtapa0")
                self.refFlow.child("Fluxos/\(self.bdRefFlow)/\(self.timeStampStep)/id_sim").setValue("idEtapa0")
                id.flow = bdRefFlow
            }
        }
    }
    
    
    func updateNavigation() {
        self.viewControllers = self.navigationController!.viewControllers
        index = 0
        if isYes == true{
            self.refFlow.child("Fluxos/\(self.bdRefFlow)/\(self.bdRefStep)/id_nao").observeSingleEvent(of: .value) { (snapshot) in
                if (snapshot.exists()){
                    for aViewController in self.viewControllers!.reversed() {
                        self.index+=1
                        if aViewController is FlowExtensiveContentViewController{
                            let alert = UIAlertController(title: "Título da Etapa", message: "Digite abaixo qual será o título para esta etapa.", preferredStyle: .alert)
                            
                            alert.addTextField { (textField) in
                                textField.placeholder = "Título Resumido"
                                textField.isSecureTextEntry = false
                            }
                            
                            alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
                            alert.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: {(action) in
                                self.refFlow.child("Fluxos/\(self.bdRefFlow)/\(self.timeStampStep)/tituloResumido").setValue(alert.textFields![0].text)
                                self.performSegue(withIdentifier: self.segueInput, sender: self)
                            }))
                            self.present(alert, animated: true, completion: nil)
                            break
                        }
                    }
                }else{
                    for aViewController in self.viewControllers!.reversed() {
                        self.index+=1
                        if aViewController is FlowExtensiveContentViewController{
                            
//                            self.viewControllers!.removeLast(self.index-1)
//
//                            self.navigationController?.viewControllers = self.viewControllers!
//                            break
                            self.viewControllers!.removeLast(self.index-1)
                            let alert = UIAlertController(title: "Título da Etapa", message: "Digite abaixo qual será o título para esta etapa.", preferredStyle: .alert)
                            
                            alert.addTextField { (textField) in
                                textField.placeholder = "Título Resumido"
                                textField.isSecureTextEntry = false
                            }
                            
                            alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
                            alert.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: {(action) in
                                self.refFlow.child("Fluxos/\(self.bdRefFlow)/\(self.timeStampStep)/tituloResumido").setValue(alert.textFields![0].text)
                                self.navigationController?.viewControllers = self.viewControllers!
                            }))
                            self.present(alert, animated: true, completion: nil)
                            break
                        }
                    }
                }
            }
        }else{
            self.refFlow.child("Fluxos/\(self.bdRefFlow)/\(self.bdRefStep)/id_sim").observeSingleEvent(of: .value) { (snapshot) in
                if (snapshot.exists()){
                    for aViewController in self.viewControllers!.reversed() {
                        self.index+=1
                        if aViewController is FlowExtensiveContentViewController{
                            let alert = UIAlertController(title: "Título da Etapa", message: "Digite abaixo qual será o título para esta etapa.", preferredStyle: .alert)
                            
                            alert.addTextField { (textField) in
                                textField.placeholder = "Título Resumido"
                                textField.isSecureTextEntry = false
                            }
                            
                            alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
                            alert.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: {(action) in
                                self.refFlow.child("Fluxos/\(self.bdRefFlow)/\(self.timeStampStep)/tituloResumido").setValue(alert.textFields![0].text)
                                self.performSegue(withIdentifier: self.segueInput, sender: self)
                            }))
                            self.present(alert, animated: true, completion: nil)
                            break
                        }
                    }
                }else{
                    for aViewController in self.viewControllers!.reversed() {
                        self.index+=1
                        if aViewController is FlowExtensiveContentViewController{
                            
                            self.viewControllers!.removeLast(self.index-1)
                            let alert = UIAlertController(title: "Título da Etapa", message: "Digite abaixo qual será o título para esta etapa.", preferredStyle: .alert)
                            
                            alert.addTextField { (textField) in
                                textField.placeholder = "Título Resumido"
                                textField.isSecureTextEntry = false
                            }
                            
                            alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
                            alert.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: {(action) in
                                self.refFlow.child("Fluxos/\(self.bdRefFlow)/\(self.timeStampStep)/tituloResumido").setValue(alert.textFields![0].text)
                                self.navigationController?.viewControllers = self.viewControllers!
                            }))
                            self.present(alert, animated: true, completion: nil)
                            break
                        }
                    }
                }
            }
        }
    }
}


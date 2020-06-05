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
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var textInitial: UILabel!
    @IBOutlet weak var contentInput: UITextField!
    @IBOutlet weak var progressBtn: UIButton!
    
    var bdRefFlow: String = "idFluxo1"
    var bdRefStep: String = "idEtapa1"
    var idScreen: String = ""
    var typeProx: String = ""
    var segueInitial: String = ""
    var teste: String = ""
    var idFlow: String = ""
    var timeStampStep = ""
    
    let refFlow = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNavBar()
        self.setupAccessibility()
        self.setupTextField()
        self.HideKeyboard()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.setupNavBar()
    }
    
    func setupTextField() {
        titleInput.attributedPlaceholder = NSAttributedString(string: "Digite o nome do fluxo", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        contentInput.attributedPlaceholder = NSAttributedString(string: "Digite a introdução do fluxo", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "appYellow")])
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "appBlue")
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "appBlue")
        self.navigationController?.navigationBar.tintColor = UIColor(named: "appColor")
        self.navigationController?.navigationBar.isTranslucent = false
     }
     
    private func setupAccessibility() {
        let titleInitialFont = UIFont(name: "SFProDisplay-Bold", size: 19) ?? UIFont.systemFont(ofSize: 22)
        let btnFont = UIFont(name: "SFProDisplay-Medium", size: 24) ?? UIFont.systemFont(ofSize: 24)
        
        self.titleInitial.dynamicFont = titleInitialFont
        self.textInitial.dynamicFont = titleInitialFont
        self.progressBtn.titleLabel?.dynamicFont = btnFont
    }
    
    
    @IBAction func btnProgress(_ sender: Any) {
        timeStampStep = "\(Int(NSDate.timeIntervalSinceReferenceDate*1000))"

        self.refFlow.child("Fluxos").childByAutoId().childByAutoId()
        idFlow = refFlow.child("Fluxos").childByAutoId().key!

        self.refFlow.child("Fluxos/\(idFlow)/\(timeStampStep)/titulo").setValue(titleInput.text)
        self.refFlow.child("Fluxos/\(idFlow)/\(timeStampStep)/subtitulo").setValue(contentInput.text)
        self.refFlow.child("Fluxos/\(idFlow)/\(timeStampStep)/descricao").setValue(contentInput.text)
        self.refFlow.child("Fluxos/\(idFlow)/\(timeStampStep)/idEtapa").setValue(timeStampStep)
        self.refFlow.child("Fluxos/\(idFlow)/\(timeStampStep)/tipo").setValue("inicial")
        self.refFlow.child("Fluxos/\(idFlow)/\(timeStampStep)/tituloResumido").setValue("Início")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueInitial"{
            if let id = segue.destination as? FlowInputViewController {
                id.bdRefFlow = self.idFlow
                id.bdRefStep = String(timeStampStep)
                id.isAlternative = false
            }
        }
    }
    
}

extension UIViewController{
    func HideKeyboard() {
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(Tap)
    }
    
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
}

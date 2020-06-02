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
    
        self.HideKeyboard()
        self.DismissKeyboard()
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
            contentInput.attributedPlaceholder = NSAttributedString(string: "Digite o nome do fluxo", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "appBlue")!])
            contentInput2.attributedPlaceholder = NSAttributedString(string: "Digite a introdução do fluxo", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "appContrast")!])
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
            contentInput.attributedPlaceholder = NSAttributedString(string: "Digite o subtítulo da etapa", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "appContrast")!])
            contentInput2.attributedPlaceholder = NSAttributedString(string: "Digite o conteúdo da etapa que será apresentado", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "appContrast")!])
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
            contentInput.attributedPlaceholder = NSAttributedString(string: "Digite a notificação da etapa", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "appContrast")!])
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
            contentInput.attributedPlaceholder = NSAttributedString(string: "Digite a notificação final", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "appContrast")!])
        default:
            break;
        }
    }
    
    @IBAction func btnProgress(_ sender: Any) {
        let timeStampStep = Int(NSDate.timeIntervalSinceReferenceDate*1000)
                
        self.refFlow.child("FluxosTeste/\(bdRefFlow)/\(timeStampStep)/titulo").setValue(contentInput.text)
        self.refFlow.child("FluxosTeste/\(bdRefFlow)/\(timeStampStep)/subtitulo").setValue("subtitulo")
        self.refFlow.child("FluxosTeste/\(bdRefFlow)/\(timeStampStep)/descricao").setValue(contentInput2.text)
        self.refFlow.child("FluxosTeste/\(bdRefFlow)/\(timeStampStep)/idEtapa").setValue(timeStampStep)
        self.refFlow.child("FluxosTeste/\(bdRefFlow)/\(timeStampStep)/tipo").setValue("teste")
        self.refFlow.child("FluxosTeste/\(bdRefFlow)/\(timeStampStep)/tituloResumido").setValue("teste")
        
        //Salvando id dessa etapa na etapa anterior
        self.refFlow.child("FluxosTeste/\(bdRefFlow)/\(bdRefStep)/id_sim").setValue(timeStampStep)
        self.refFlow.child("FluxosTeste/\(bdRefFlow)/\(bdRefStep)/id_nao").setValue(timeStampStep)
    }
}


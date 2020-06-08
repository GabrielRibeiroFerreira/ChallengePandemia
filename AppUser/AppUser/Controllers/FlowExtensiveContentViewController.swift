//
//  FlowExtensiveContentViewController.swift
//  AppUser
//
//  Created by Inara Takashi on 24/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//  APPUSER

import UIKit
import FirebaseDatabase

class FlowExtensiveContentViewController: UIViewController {
    @IBOutlet weak var titleContent: UILabel!
    @IBOutlet weak var subtitleContent: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var progressBtn: UIButton!
    
    @IBOutlet weak var btnDrop: UIButton!
    
    @IBOutlet weak var tblView: UITableView!
    
    var bdRefFlow: String = ""
    var bdRefStep: String = ""
    var idScreen: String = ""
    var typeProx: String = ""
    var segueExtensive: String = ""
    var isYes = true
    var timeStampStepYes = 0
    var timeStampStepNo = 0
    var viewControllers: [UIViewController]?
    
    var listOptions = ["Sim", "Não"]
    
    let refFlow = Database.database().reference()
    let dispatchGroup1 = DispatchGroup()
    let dispatchGroup2 = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavBar()
        tblView.isHidden = true
        
        let urlFlowAtual = "Fluxos/" + self.bdRefFlow + "/" + self.bdRefStep
        self.refFlow.child(urlFlowAtual + "/titulo").observeSingleEvent(of: .value) { (snapshot) in
            self.titleContent.text = (snapshot.value as? String)!
        }
        self.refFlow.child(urlFlowAtual + "/subtitulo").observeSingleEvent(of: .value) { (snapshot) in
            self.listOptions = ["\(snapshot.value as! String)" + " - " + self.listOptions[0],"\(snapshot.value as! String)" + " - " + self.listOptions[1]]
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
    
    
    @IBAction func btnProgress(_ sender: Any) {
        self.performSegue(withIdentifier: "segueFlow", sender: self)

    }
    
    
    @IBAction func onClickDropBtn(_ sender: Any) {
        if tblView.isHidden{
            animate(toggle: true)
        }else{
            animate(toggle: false)
        }
    }
    
    func animate(toggle: Bool){
        if toggle{
            UIView.animate(withDuration: 0.3){
                self.tblView.isHidden = false
                self.btnDrop.setBackgroundImage(UIImage(named: "botao-itens-aberto"), for: .normal)
            }
        }else{
            UIView.animate(withDuration: 0.3){
                self.tblView.isHidden = true
                self.btnDrop.setBackgroundImage(UIImage(named: "botao-itens-fechado"), for: .normal)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFlow"{
            if let id = segue.destination as? FlowInputViewController {
                id.bdRefFlow = bdRefFlow
                id.bdRefStep = bdRefStep
                id.isYes = isYes
                id.isAlternative = true
                id.viewControllers = viewControllers
            }
        }else if segue.identifier == "toStageSegue"{
            if let etapas = segue.destination as? EtapasViewController {
                etapas.flow = self.bdRefFlow
            }
        }
    }
    
}

extension FlowExtensiveContentViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = listOptions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        btnDrop.setTitle("\(listOptions[indexPath.row])", for: .normal)
        animate(toggle: false)
        if indexPath.row == 0{
            self.isYes = true
        }else{
            self.isYes = false
        }
    }
    
}

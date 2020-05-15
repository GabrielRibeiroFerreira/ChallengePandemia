//
//  EtapasViewController.swift
//  AppUser
//
//  Created by Luma Gabino Vasconcelos on 27/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit
import Firebase

class EtapasViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let etapaCellIdentifier: String = "TituloEtapaViewCell"
    var stageTitles: [Etapa] = []
    let appBlue = UIColor(named: "appBlue")
    let appColor = UIColor(named: "appColor")
    
    var etapas = [Etapa]()
    var alternativaStack:[Etapa] = []
    var avancarStack:[Etapa] = []
    var titleList:[Etapa] = []
    
    //Id da etapa de origem da tela de Etapas
    var markedStage: String = "idEtapa1"
    
    var flow: String = "idFluxo1"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.setupAccessibility()
        
        let nib = UINib.init(nibName: self.etapaCellIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: self.etapaCellIdentifier)
        
        self.setupNavBar()
        
        self.getDataFromDB()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNavBar()
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Etapas"
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "appBlue")
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "appBlue")
        self.navigationController?.navigationBar.tintColor = UIColor(named: "appColor")
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: self.appColor ?? UIColor.blue]
        
        //"Ir para Lista" right navBar button
        let button = UIButton(type: .custom)
        button.setTitle("Ir para Lista", for: .normal)
        button.setTitleColor(UIColor(named: "appColor"), for: .normal)
        button.addTarget(self, action: #selector(goToList(sender:)), for: .touchUpInside)
        let rightItem = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func getDataFromDB() {
        let urlFlow = "Fluxos/" + self.flow + "/Etapas"
        let refFlow = Database.database().reference().child(urlFlow)
        refFlow.observe(.value) { (snapshot) in
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let tituloResumido = dict["tituloResumido"] as? String,
                    let idEtapa = dict["idEtapa"] as? String,
                    let id_sim = dict["id_sim"] as? String,
                    let id_nao = dict["id_nao"] as? String,
                    let tipo = dict["tipo"] as? String {
                    
                    let etapa = Etapa(tituloResumido: tituloResumido, idEtapa: idEtapa, id_sim: id_sim, id_nao: id_nao, tipo: tipo)
                    self.etapas.append(etapa)
                }
            }
            self.sortTitles()
        }
    }

    func sortTitles() {
        var currentEtapa: Etapa
        
        //Etapa inicial do fluxo
        for etapa in self.etapas {
            if etapa.tipo == "inicial" {
                titleList.append(etapa)
                addProxRightList(proxEtapa: etapa.id_sim!)
            }
        }
        
        //Ordenação árvore de protocolos/fluxos a partir da etapa inicial
        while !alternativaStack.isEmpty || !avancarStack.isEmpty {
            if !avancarStack.isEmpty {
                currentEtapa = avancarStack.popLast()!
                titleList.append(currentEtapa)
                addProxRightList(proxEtapa: currentEtapa.id_sim!)
            }
            else {
                currentEtapa = alternativaStack.popLast()!
                titleList.append(currentEtapa)
                addProxRightList(proxEtapa: currentEtapa.id_sim!)
                addProxRightList(proxEtapa: currentEtapa.id_nao!)
            }
        }
        stageTitles = self.titleList
        tableView.reloadData()
    }
    
    //Função auxiliar que verifica o tipo da próxima etapa a ser visistida
    //e adiciona a pilha correta
    func addProxRightList(proxEtapa: String) {
        for etapa in self.etapas {
            if etapa.idEtapa == proxEtapa {
                if etapa.tipo == "alternativa" {
                    self.alternativaStack.append(etapa)
                }
                else if etapa.tipo == "avancarCurto" || etapa.tipo == "avancarExtenso" {
                    self.avancarStack.append(etapa)
                }
                else if etapa.tipo == "final" {
                    self.titleList.append(etapa)
                }
            }
        }
    }
    
    
    private func setupAccessibility() {
        let titleFont = UIFont(name: "SFProDisplay-Bold", size: 24) ?? UIFont.systemFont(ofSize: 24)

        self.titleLabel.dynamicFont = titleFont
        
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        self.titleLabel.font = fontMetrics.scaledFont(for: titleFont, maximumPointSize: 40.0)
    }
    
    @objc func goToList(sender: UIButton) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in viewControllers {
            if aViewController is AreaViewController {
                self.navigationController!.popToViewController(aViewController, animated: true)
            }
        }
    }
    
}


// MARK: - Table view extension
extension EtapasViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stageTitles.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let stage = self.stageTitles[indexPath.row]
        
        //DFS - retornando a lista das etapas (incial -> selecionada)
        
        self.updateNavigation()
        
    }
    
    func updateNavigation() {
        var viewControllers: [UIViewController] = self.navigationController!.viewControllers
        var size = viewControllers.count
        
        for aViewController in viewControllers {
            size = size-1
            if aViewController is FlowInitialViewController {
                
                //Remove todas as telas até a FlowInitial
                viewControllers.removeLast(size)
                
                //Criação lista de etapas do fluxos
                //PASSAR AQUI A LISTA ENCONTRADA PELA DFS
                var  testList:[Etapa] = []
                let etapa1 = Etapa(tituloResumido: "→ Sindrome Gripal", idEtapa: "idEtapa1", id_sim: "idEtapa2", id_nao: "idEtapa2", tipo: "inicial")
                let etapa2 = Etapa(tituloResumido: "→ Sinais de gravidade?", idEtapa: "idEtapa2", id_sim: "idEtapa4", id_nao: "idEtapa2", tipo: "alternativa")
                let etapa3 = Etapa(tituloResumido: "• Síndrome Respiratória Aguda Grave", idEtapa: "idEtapa3", id_sim: "idEtapa5", id_nao: "idEtapa5", tipo: "avancarCurto")
                let etapa4 = Etapa(tituloResumido: "• Suporte intensivo", idEtapa: "idEtapa6", id_sim: "idEtapa8", id_nao: "idEtapa8", tipo: "avancarExtenso")
                testList.append(etapa1)
                testList.append(etapa2)
                testList.append(etapa3)
                testList.append(etapa4)
                
                let newNavList = self.instanciateNewNavigation(stageList: testList)
                
                //Atualiza navigation com nova lista de UIViewControllers
                self.navigationController?.viewControllers = viewControllers + newNavList
            }
        }
    }
    
    func instanciateNewNavigation(stageList: [Etapa]) -> [UIViewController] {
        var list: [UIViewController] = []
        
        //Percorre lista e instancia cada VC
        for stage in stageList {
            if stage.tipo == "avancarCurto" {
                let storyboard = UIStoryboard.init(name: "FlowShortContent", bundle: Bundle.main)
                if let mainVC = storyboard.instantiateInitialViewController() {
                    if let vc = mainVC as? FlowShortContentViewController {
                        vc.bdRefFlow = self.flow
                        vc.bdRefStep = stage.idEtapa!
                        list.append(vc)
                    }
                }
            }
            else if stage.tipo == "avancarExtenso" {
               let storyboard = UIStoryboard.init(name: "FlowExtensiveContent", bundle: Bundle.main)
               if let mainVC = storyboard.instantiateInitialViewController() {
                   if let vc = mainVC as? FlowExtensiveContentViewController {
                       vc.bdRefFlow = self.flow
                       vc.bdRefStep = stage.idEtapa!
                       list.append(vc)
                   }
               }
            }
            else if stage.tipo == "alternativa" {
               let storyboard = UIStoryboard.init(name: "FlowInput", bundle: Bundle.main)
               if let mainVC = storyboard.instantiateInitialViewController() {
                   if let vc = mainVC as? FlowInputViewController {
                       vc.bdRefFlow = self.flow
                       vc.bdRefStep = stage.idEtapa!
                       list.append(vc)
                   }
               }
            }
            else if stage.tipo == "final" {
               let storyboard = UIStoryboard.init(name: "FlowFinal", bundle: Bundle.main)
               if let mainVC = storyboard.instantiateInitialViewController() {
                   if let vc = mainVC as? FlowInputViewController {
                       vc.bdRefFlow = self.flow
                       vc.bdRefStep = stage.idEtapa!
                       list.append(vc)
                   }
               }
            }
        }
        
        return list
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.etapaCellIdentifier, for: indexPath) as! TituloEtapaViewCell
        let stage = self.stageTitles[indexPath.row].tituloResumido
        cell.titleLabel.text = stage

        //Verifica se é uma etapa de alternativa
        if self.stageTitles[indexPath.row].tipo == "inicial" || self.stageTitles[indexPath.row].tipo == "alternativa" {
            
            let titleFont = UIFont(name: "SFProDisplay-Heavy", size: 18) ?? UIFont.systemFont(ofSize: 18)
            cell.titleLabel.dynamicFont = titleFont
        }
        else {
            let titleFont = UIFont(name: "SFProDisplay-Regular", size: 18) ?? UIFont.systemFont(ofSize: 18)
            cell.titleLabel.dynamicFont = titleFont
            
        }
        
        //Verifica se é a etapa atual visualizada
        if stageTitles[indexPath.row].idEtapa == self.markedStage {
            cell.circleView.image = UIImage(named: "stageSelected")
        }
        else {
            cell.circleView.image = UIImage(named: "stageNotSelected")
        }
        
        return cell
    }
}

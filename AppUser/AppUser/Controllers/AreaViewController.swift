//
//  AreaViewController.swift
//  AppUser
//
//  Created by Gabriel Ferreira on 23/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AreaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var area : String = ""
    var bdRefArea: String = ""
    var bdRefRoom: String = ""
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var protocolTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var addButton: UIButton!
    
    let protocolIdentifier : String = "ProtocolTableViewCell"
    
    var protList : [ProtFlow] = []
    var fluxList : [ProtFlow] = []
    var list : [ProtFlow] = []
    
    var searchActive : Bool = false
    
    var selectedFlow: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.area

        if #available(iOS 13.0, *) {
            let textField = self.searchBar.searchTextField
            textField.backgroundColor = UIColor(named: "appYellow")
            
            textField.textColor = .black
            textField.attributedPlaceholder = NSAttributedString(string: "Pesquisar", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            textField.tintColor = .black
        } else {
            let textField = self.searchBar.value(forKey: "searchField") as! UITextField
            
            textField.backgroundColor = UIColor(named: "appYellow")
            textField.textColor = .black
            textField.attributedPlaceholder = NSAttributedString(string: "Pesquisar", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            textField.tintColor = .black
        }
        self.searchBar.delegate = self
        
        definesPresentationContext = true
        self.segmented.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "appColor") ?? UIColor.lightText], for: .selected)
        
        self.protocolTable.delegate = self
        self.protocolTable.dataSource = self
        self.protocolTable.indexDisplayMode = .alwaysHidden
        
        let nib = UINib.init(nibName: self.protocolIdentifier, bundle: nil)
        self.protocolTable.register(nib, forCellReuseIdentifier: self.protocolIdentifier)
        
        //Bordas do botão arredondadas
        self.addButton.layer.cornerRadius = 16.0
        
        self.setupAccessibility()
        self.setupNavBar()
        self.getDataFromDB()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavBar()
    }
    private func setupAccessibility() {
        let buttonFont = UIFont(name: "SFProDisplay-Medium", size: 24) ?? UIFont.systemFont(ofSize: 24)
        self.addButton.titleLabel?.dynamicFont = buttonFont
    }

    
    func setupNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.title = self.area
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "appColor")
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "appColor") ?? UIColor.blue
        self.navigationController?.navigationBar.tintColor = UIColor(named: "appBlue")
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(named: "appBlue") ?? UIColor.black]
    }
    
    func getDataFromDB() {
        //Recuperação Fluxos
        let urlFlow = "Areas/" + self.bdRefRoom + "/" + self.bdRefArea + "/Fluxos"
        let refFlow = Database.database().reference().child(urlFlow)
        refFlow.observe(.value) { (snapshot) in
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let titulo = dict["titulo"] as? String {
                    
                    let flow = ProtFlow(key: childSnapshot.key, titulo: titulo)
                    self.fluxList.append(flow)
                }
            }
        }
        
        //Recuperação Protocolos
        let urlProt = "Areas/" + self.bdRefRoom + "/" + self.bdRefArea + "/Protocolos"
        let refProt = Database.database().reference().child(urlProt)
        refProt.observe(.value) { (snapshot) in
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let titulo = dict["titulo"] as? String {
                    
                    let prot = ProtFlow(key: childSnapshot.key, titulo: titulo)
                    self.protList.append(prot)
                }
            }
            //Atualiza lista com novos valores e recarrega tableview
            DispatchQueue.main.async {
                self.list = self.getList()
                self.protocolTable.reloadData()
            }
        }
    }
    
    // MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.protocolIdentifier, for: indexPath) as! ProtocolTableViewCell
        let actual = self.list[indexPath.row]

        cell.nameLabel.text = actual.titulo

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath)
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        if let flowKey = self.list[indexPath.row].key {
            self.selectedFlow = flowKey
            performSegue(withIdentifier: "initialFlowSegue", sender: cell)
        }
    }
       
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "initialFlowSegue" {
            if let flowInitialView = segue.destination as? FlowInitialViewController {
                flowInitialView.bdRefFlow = self.selectedFlow
            }
        }
    }
    
    // MARK: - Segmented Control
    @IBAction func indexChanged(_ sender: Any) {
        self.list = self.getList()
        self.protocolTable.reloadData()
    }
    
    func getList() -> [ProtFlow] {
        var actual : [ProtFlow]
        
        switch self.segmented.selectedSegmentIndex {
        case 0:
            actual = self.fluxList
        case 1:
            actual = self.protList
        default:
            actual = self.protList + self.fluxList
        }
        
        return actual
    }
    
    // MARK: - Search
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.list = getList()
        self.list = self.list.filter{ (text) -> Bool in
            let textTitle = text.titulo ?? ""
            let tmp: NSString = textTitle as NSString
            let range = tmp.range(of: searchText, options: [NSString.CompareOptions.diacriticInsensitive, NSString.CompareOptions.caseInsensitive])
            return range.location != NSNotFound
        }
        if(self.list.count == 0){
            if searchText.count == 0 {
                self.list = self.getList()
            }
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.protocolTable.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar?.endEditing(true)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar?.endEditing(true)
    }

}

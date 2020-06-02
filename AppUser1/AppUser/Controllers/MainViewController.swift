//
//  ViewController.swift
//  AppUser
//
//  Created by Gabriel Ferreira on 17/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
// oh carai

import UIKit
import FirebaseDatabase

class MainViewController: UITableViewController, UISearchBarDelegate {
    var sectionView : SearchViewHeader!
    var searchBar: UISearchBar!
    
    let roomIdentifier : String = "RoomTableViewCell"
    let searchIdentifier : String = "SearchView"
    let sectionIdentifier : String = "InitialView"
    
    var rooms : [Room] = []
    var ids : [String] = []
    var selectedRoom : Room?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: self.roomIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: self.roomIdentifier)
        
        let nib2 = UINib.init(nibName: self.searchIdentifier, bundle: nil)
        self.tableView.register(nib2, forHeaderFooterViewReuseIdentifier: self.searchIdentifier)
        let nib3 = UINib.init(nibName: self.sectionIdentifier, bundle: nil)
        self.tableView.register(nib3, forHeaderFooterViewReuseIdentifier: self.sectionIdentifier)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.indexDisplayMode = .alwaysHidden
        
        //Deixa status bar com fundo azul
        self.view.backgroundColor = UIColor(named: "appBlue") ?? UIColor.blue
        
        self.setupNavBar()
        self.ids = UserDefaults.standard.array(forKey: "rooms") as? [String] ?? []
        self.getDataFromDB()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNavBar()
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.title = "Olá,"
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "appBlue")
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "appBlue") ?? UIColor.blue
        self.navigationController?.navigationBar.tintColor = UIColor(named: "appColor")
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "appColor") ?? UIColor.white]
    }
    
    //MARK: -DB
    
    func getDataFromDB() {
        var roomsDB : [Room] = []
        let url = "Salas"
        let ref = Database.database().reference().child(url)
        ref.observe(.value) { (snapshot) in
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let name = dict["name"] as? String,
                    let code = dict["code"] as? String,
                    let idAdm = dict["idAdm"] as? String {
                    
                    let room = Room(name: name, idAdm: idAdm, key: childSnapshot.key, code: code)
                    roomsDB.append(room)
                }
            }
            for room in roomsDB {
                if self.ids.contains(room.key!) {
                    self.rooms.append(room)
                }
            }
            self.tableView.reloadData()
        }
    }

    //MARK: -TableView
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var sec : UIView?
        
        switch section {
        case 0:
            let initial = tableView.dequeueReusableHeaderFooterView(withIdentifier: self.sectionIdentifier) as? InitialViewHeader
            
            sec = initial
        case 1:
            self.sectionView = tableView.dequeueReusableHeaderFooterView(withIdentifier: self.searchIdentifier) as? SearchViewHeader
            
            self.searchBar = self.sectionView.searchBar

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
            
            self.sectionView.addRoomButton.addTarget(self, action: #selector(self.addRoom(_:)), for: .touchUpInside)
            sec = self.sectionView
        default:
            sec = nil
        }
        
        return sec
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num : Int
        switch section {
        case 0:
            num = 0
        case 1:
            num = self.rooms.count
            print("---------------------")
            print(rooms.count)
            print("---------------------")
        default:
            num = 0
        }
        return num
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.roomIdentifier, for: indexPath) as! RoomTableViewCell
        let room = self.rooms[indexPath.row].name
        print("---------------------")
        print(rooms.count)
        print("---------------------")
        cell.nameLabel.text = room
        
        return cell
    }
    
    @objc func addRoom(_ sender: UIButton!) {
        let alert = UIAlertController(title: "Adicionar Sala", message: "", preferredStyle: .alert)
        
//        alert.addTextField { (textField)
        alert.addTextField { (textField) in
            textField.placeholder = "código da sala"
            textField.isSecureTextEntry = true
        }
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Adicionar", style: .default, handler: {(action) in
//            let name = alert.textFields![0].text
            let code = alert.textFields![0].text
            self.getRoom(code: code ?? "")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func getRoom(code : String){
        var room : Room?
        let url = "Salas"
        let ref = Database.database().reference().child(url)
        ref.observe(.value) { (snapshot) in
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let nameBD = dict["name"] as? String,
                    let codeBD = dict["code"] as? String,
                    let idAdmBD = dict["idAdm"] as? String {
                    if code == codeBD {
                        room = Room(name: nameBD, idAdm: idAdmBD, key: childSnapshot.key, code: codeBD)
                        break
                    }
                }
            }
            if room == nil {
                let alertFail = UIAlertController(title: "Falhou", message: "", preferredStyle: .alert)
                self.present(alertFail, animated: true, completion: nil)
                alertFail.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {(action) in
                }))
            } else {
                if self.rooms.count == 0 {
                    self.rooms.append(room!)
                    self.ids.append(room!.key!)
                } else {
                    var add : Bool = true
                    for r in self.rooms {
                        if r.key == room?.key {
                            add = false
                            break
                        }
                    }
                    if add {
                        self.rooms.append(room!)
                        self.ids.append(room!.key!)
                    }
                }
                UserDefaults.standard.set(self.ids, forKey: "rooms")
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath)
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        self.selectedRoom = self.rooms[indexPath.row]
        performSegue(withIdentifier: "roomSegue", sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "roomSegue"{
            if let areasView = segue.destination as? AreasTableViewController {
                areasView.room = self.selectedRoom
            }
        }
    }
    
    // MARK: - SearchBar & Keyboard
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar?.endEditing(true)
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar?.endEditing(true)
    }
    
}


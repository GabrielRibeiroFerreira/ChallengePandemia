//
//  ViewController.swift
//  AppUser
//
//  Created by Gabriel Ferreira on 17/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController, UISearchBarDelegate {
    var sectionView : SearchViewHeader!
    var searchBar: UISearchBar!
    
    let roomIdentifier : String = "RoomTableViewCell"
    let searchIdentifier : String = "SearchView"
    let sectionIdentifier : String = "InitialView"
    
    var rooms : [String] = ["Ministério da Saúde", "Hospital das Clínicas Unicamp", "Hospital", "Hospital", "Hospital", "Hospital", "Hospital", "Hospital", "Hospital", "Hospital", "Hospital", "Hospital", "Hospital", "Hospital", "Hospital", "Hospital", "Hospital", "Hospital"]
    var selectedRoom : String?
    
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

    //MARK: -TableView
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var sec : UIView?
        
        switch section {
        case 0:
            let initial = tableView.dequeueReusableHeaderFooterView(withIdentifier: self.sectionIdentifier) as? InitialViewHeader
            print(initial?.initialLabel.text)
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
        default:
            num = 0
        }
        return num
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.roomIdentifier, for: indexPath) as! RoomTableViewCell
        let room = self.rooms[indexPath.row]

        cell.nameLabel.text = room
        
        return cell
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


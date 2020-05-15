//
//  AreasTableViewController.swift
//  AppUser
//
//  Created by Gabriel Ferreira on 20/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit

class AreasTableViewController: UITableViewController {
    var room : String?
    let areaIdentifier : String = "AreaTableViewCell"
    let areas : [(name : String, image : UIImage, shortName: String, bdRef: String)] = [(NSLocalizedString("Saúde da Criança e do Adolescente", comment: "children"), UIImage(named: "iconChildren") ?? UIImage(), "Saúde da Criança", "Crianca"), (NSLocalizedString("Saúde da Mulher", comment: "woman"), UIImage(named: "iconWoman") ?? UIImage(), "Saúde da Mulher", "Mulher"), (NSLocalizedString("Saúde do Adulto e do Idoso", comment: "adult"), UIImage(named: "iconAdult") ?? UIImage(), "Saúde do Adulto", "Adulto"), (NSLocalizedString("Urgência e Emergência", comment: "primary"), UIImage(named: "iconPrimary") ?? UIImage(), "Urgência e Emergência", "Urgencia")]
    
    var selectedArea : String = ""
    var bdRefArea: String = ""
    var bdRefRoom: String  = "idSala1"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.indexDisplayMode = .alwaysHidden
        
        let nib = UINib.init(nibName: self.areaIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: self.areaIdentifier)
        
        self.title = self.room
        self.setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNavBar()
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.title = "Hospital"
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "appColor")
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "appColor") ?? UIColor.blue
        self.navigationController?.navigationBar.tintColor = UIColor(named: "appBlue")
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "appBlue") ?? UIColor.white]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.areas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.areaIdentifier, for: indexPath) as! AreaTableViewCell
        let area = self.areas[indexPath.row]

        cell.nameLabel.text = area.name
        cell.iconImage.image = area.image

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Áreas da Saúde"
    }
    
    // MARK: - Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath)
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        self.selectedArea = self.areas[indexPath.row].shortName
        self.bdRefArea = self.areas[indexPath.row].bdRef
        performSegue(withIdentifier: "areaSegue", sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "areaSegue"{
            if let areaView = segue.destination as? AreaViewController {
                areaView.area = self.selectedArea
                areaView.bdRefArea = self.bdRefArea
                areaView.bdRefRoom = self.bdRefRoom
            }
        }
    }
}

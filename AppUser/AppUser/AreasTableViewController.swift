//
//  AreasTableViewController.swift
//  AppUser
//
//  Created by Gabriel Ferreira on 20/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit

class AreasTableViewController: UITableViewController {
    let areaIdentifier : String = "AreaTableViewCell"
    let areas : [(name : String, image : UIImage)] = [(NSLocalizedString("Saúde da Criança e do Adolescente", comment: "children"), UIImage(named: "iconChildren") ?? UIImage()), (NSLocalizedString("Saúde da mulher", comment: "woman"), UIImage(named: "iconWoman") ?? UIImage()), (NSLocalizedString("Saúde do Adulto e do Idoso", comment: "adult"), UIImage(named: "iconAdult") ?? UIImage()), (NSLocalizedString("Atenção Primária à Saúde", comment: "primary"), UIImage(named: "iconPrimary") ?? UIImage())]
    var selectedArea : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(named: "appBlue") ?? UIColor.black]
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.indexDisplayMode = .alwaysHidden
        
        let nib = UINib.init(nibName: self.areaIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: self.areaIdentifier)
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
        self.selectedArea = self.areas[indexPath.row].name
        performSegue(withIdentifier: "areaSegue", sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "areaSegue"{
            if let areaView = segue.destination as? AreaViewController {
                    areaView.area = self.selectedArea
            }
        }
    }
}

//
//  AreaViewController.swift
//  AppUser
//
//  Created by Gabriel Ferreira on 23/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit

class AreaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var area : String?
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var protocolTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let protocolIdentifier : String = "ProtocolTableViewCell"
    let protList : [String] = ["Lorem Ipsum é que nem os comportamentos machistas dentro da criação. Você não presta atenção, só sai reproduzindo por aí.", "Lorem Ipsum é que nem os comportamentos machistas dentro da criação. Você não presta atenção, só sai reproduzindo por aí.", "Lorem Ipsum é que nem os comportamentos machistas dentro da criação. Você não presta atenção, só sai reproduzindo por aí."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.area
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(named: "appBlue") ?? UIColor.black]
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
        
        self.segmented.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "appColor") ?? UIColor.lightText], for: .selected)
        
        self.protocolTable.delegate = self
        self.protocolTable.dataSource = self
        self.protocolTable.indexDisplayMode = .alwaysHidden
        
        let nib = UINib.init(nibName: self.protocolIdentifier, bundle: nil)
        self.protocolTable.register(nib, forCellReuseIdentifier: self.protocolIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.protList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.protocolIdentifier, for: indexPath) as! ProtocolTableViewCell
        let prot = self.protList[indexPath.row]

        cell.nameLabel.text = prot

        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

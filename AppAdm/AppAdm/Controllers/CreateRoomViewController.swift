//
//  CreateRoomViewController.swift
//  AppAdm
//
//  Created by Gabriel Ferreira on 29/05/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CreateRoomViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var keyTextField: UITextField!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var descriptionKeyLabel: UILabel!
    
    var id : Int = 0
    var keyIsEnabled : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupAccessibility()
        self.getId()
        self.setupNavBar()
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "appColor")
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "appColor") ?? UIColor.blue
        self.navigationController?.navigationBar.tintColor = UIColor(named: "appBlue")
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "appBlue") ?? UIColor.white]
    }

    private func setupAccessibility() {
        let font = UIFont(name: "SFProDisplay-Bold", size: 17) ?? UIFont.systemFont(ofSize: 17)
        
        self.descriptionLabel.dynamicFont = font
        self.nameLabel.dynamicFont = font
        self.keyLabel.dynamicFont = font
        self.descriptionKeyLabel.dynamicFont = font
    }
    
    @IBAction func keyChanged(_ sender: Any) {
        self.keyTextField.text = ""
        self.keyIsEnabled = !self.keyIsEnabled
        self.keyTextField.isEnabled = self.keyIsEnabled
    }
    
    func getId() {
        let url = "Salas"
        let ref = Database.database().reference().child(url)
        ref.observe(.value) { (snapshot) in
            var keys : [String] = []
            if let data = snapshot.value as? [String:Any] {
                keys = Array(data.keys)
            }
            
            repeat{
                self.id = Int.random(in: 0...1000)
            }while keys.contains("idSala\(self.id)")
        }
    }

    @IBAction func createRoomAction(_ sender: Any) {
        let key = self.keyIsEnabled ? self.keyTextField.text : "publico"
        let idAdm = "idAdm" + String(UserDefaults.standard.integer(forKey: "idAdm"))
        let name = self.nameTextField.text
        let room = ["idSala\(self.id)" :
                        ["code" : key as Any,
                         "idAdm" : idAdm as Any,
                         "name" : name as Any]]
        let roomRef = Database.database().reference(withPath : "Salas")
        roomRef.updateChildValues(room)
        
        self.returnAfterCreate()
    }
    
    func returnAfterCreate() {
        let action = UIAlertController(title: "Sala criada!", message: "", preferredStyle: .alert)
        action.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for aViewController in viewControllers {
                if aViewController is MainViewController {
                    self.navigationController!.popToViewController(aViewController, animated: true)
                }
            }
        }))
        
        self.present(action, animated: true, completion: nil)
    }
}

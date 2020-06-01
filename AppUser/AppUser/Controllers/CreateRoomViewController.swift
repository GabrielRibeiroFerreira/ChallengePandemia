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
    
    var id : Int = 0
    var keyIsEnabled : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getId()
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
        let name = self.nameTextField.text
        let room = ["idSala\(self.id)" :
                        ["code" : key as Any,
                         "idAdm" : "idAdm10" as Any,
                         "name" : name as Any]]
        let roomRef = Database.database().reference(withPath : "Salas")
        roomRef.updateChildValues(room)
    }
}

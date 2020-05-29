//
//  CreateRoomViewController.swift
//  AppAdm
//
//  Created by Gabriel Ferreira on 29/05/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit

class CreateRoomViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var keyTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func createRoomAction(_ sender: Any) {
        let room = ["idSala\(self.key)" :
                        ["code" : self.keyTextField.text as Any,
                         "idAdm" : self.keyTextField.text as Any,
                         "name" : self.nameTextField as Any]]
        let roomRef = Database.database().reference(withPath : "salas/")
        roomRef.updateChildValues(room)
    }
}

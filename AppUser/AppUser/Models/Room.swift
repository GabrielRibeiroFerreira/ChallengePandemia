//
//  Room.swift
//  AppUser
//
//  Created by Luma Gabino Vasconcelos on 29/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import Foundation

class Room: Codable {
    let name: String?
    let idAdm: String?
    let key: String?
    let code: String?
    //let areas: [Areas]
    

    init(name: String, idAdm: String, key: String, code: String) {
        self.name = name
        self.idAdm = idAdm
        self.key = key
        self.code = code
    }
}

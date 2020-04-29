//
//  Room.swift
//  AppUser
//
//  Created by Luma Gabino Vasconcelos on 29/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import Foundation

class Room: Codable {
    let idSala: Int?
    let name: String?
    let idAdm: Int?
    let key: String?
    //let areas: [Areas]
    

    init(idSala: Int, name: String, idAdm: Int, key: String) {
        self.idSala = idSala
        self.name = name
        self.idAdm = idAdm
        self.key = key
    }
}

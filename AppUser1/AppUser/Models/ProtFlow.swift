//
//  ProtFlow.swift
//  AppUser
//
//  Created by Luma Gabino Vasconcelos on 11/05/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import Foundation

class ProtFlow: Codable {
    let key: String?
    let titulo: String?
    
    init(key: String, titulo: String) {
        self.key = key
        self.titulo = titulo
    }
}

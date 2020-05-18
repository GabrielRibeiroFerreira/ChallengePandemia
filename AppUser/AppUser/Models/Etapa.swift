//
//  Etapa.swift
//  AppUser
//
//  Created by Luma Gabino Vasconcelos on 13/05/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import Foundation

class Etapa: Codable {
    let tituloResumido: String?
    let idEtapa: String?
    let id_sim: String?
    let id_nao: String?
    let tipo: String?
    
    init(tituloResumido: String, idEtapa: String, id_sim: String, id_nao: String, tipo: String) {
        self.tituloResumido = tituloResumido
        self.idEtapa = idEtapa
        self.id_sim = id_sim
        self.id_nao = id_nao
        self.tipo = tipo
    }
    
    init() {
        
    }
}

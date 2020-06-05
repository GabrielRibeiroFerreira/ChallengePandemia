//
//  RoomResponse.swift
//  AppUser
//
//  Created by Luma Gabino Vasconcelos on 29/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import Foundation

class RoomResponse: Codable {
    let results: [Room]

    init(results: [Room]) {
        self.results = results
    }
}

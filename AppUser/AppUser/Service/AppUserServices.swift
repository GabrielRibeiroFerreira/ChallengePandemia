//
//  AppUserServices.swift
//  AppUser
//
//  Created by Luma Gabino Vasconcelos on 29/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import Foundation

class AppUserServices: BaseService {
    func getAllRooms(router: AppUserRouter = AppUserRouter.getAllCharacters, completion: @escaping (Result<RoomResponse, Error>) -> ()) {
        return self.request(router: router, completion: completion)
    }
    
}


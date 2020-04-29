//
//  AppUserRouters.swift
//  AppUser
//
//  Created by Luma Gabino Vasconcelos on 29/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import Foundation

enum AppUserRouter: Router {
    case getAllRooms
    //case getRoom(id: Int)
    
    var host: String { return "hostname.com"}
    
    var path: String {
        switch self {
        case .getAllRooms:
            return "/rooms/"
//        case .getRoom(let id):
//            return "/rooms/\(id)"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getAllRooms:
            return []
        }
    }
    
    var method: String {
        switch self {
        case .getAllRooms:
            return "GET"
        }
    }
    
}

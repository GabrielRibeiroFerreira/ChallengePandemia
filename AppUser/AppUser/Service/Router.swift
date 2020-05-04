//
//  Router.swift
//  AppUser
//
//  Created by Luma Gabino Vasconcelos on 29/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import Foundation

protocol Router {
    var host: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var method: String { get }
}

//
//  BaseService.swift
//  AppUser
//
//  Created by Luma Gabino Vasconcelos on 29/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import Foundation

class BaseService {
    
    func request<T: Codable>(router: Router, completion: @escaping (Result<T, Error>) -> ()) {
        // Componentes
        var components = URLComponents()
        components.scheme = "https"
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters
        
        // Request
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        
        // Resposta servidor
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data,  error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription ?? "")
                return
            }
            
            // Decodificação
            let responseObject = try! JSONDecoder().decode(T.self, from: data)
   
            completion(.success(responseObject))
            
        }
        dataTask.resume()
    }
}


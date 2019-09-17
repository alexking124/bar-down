//
//  NetworkManager.swift
//  Bar Down
//
//  Created by Alex King on 8/29/19.
//  Copyright © 2019 Pryanik. All rights reserved.
//

import Foundation
import Combine

struct NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func publisher<R: Request>(for request: R) -> AnyPublisher<R.ResponseType, URLError> {
        let urlRequest = URLRequest(url: request.url)
        return URLSession.shared.dataTaskPublisher(for: urlRequest).compactMap { response -> R.ResponseType? in
            do {
//                print(try JSONSerialization.jsonObject(with: response.data, options: []))
                return try request.deserialize(response.data)
            } catch {
                print(error)
                return nil
            }
        }.eraseToAnyPublisher()
    }
    
}

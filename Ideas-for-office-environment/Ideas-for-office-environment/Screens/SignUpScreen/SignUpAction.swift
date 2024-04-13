//
//  SignUpAction.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 08.04.2024.
//

import Foundation

struct SignUpAction: Encodable {
    
    var parameters: SignUpRequest
    
    func call(completion: @escaping (Result<SignUpResponse, NetworkError>) -> Void) {
        let scheme: String = "http"
        let host: String = "localhost"
        let port: Int = 8189
        let path = "/api/auth/register"

        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        components.path = path
        
        guard let url = components.url else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "post"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            request.httpBody = try JSONEncoder().encode(parameters)
        } catch {
            // Error: Unable to encode request parameters
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                let response = try? JSONDecoder().decode(SignUpResponse.self, from: data)
                
                if let response = response {
                    completion(.success(response))
                } else {
                    // Error: Unable to decode response JSON
                    completion(.failure(.wrongUser))
                }
            } else {
                // Error: API request failed
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}

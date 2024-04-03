//
//  SignInAction.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 03.04.2024.
//

import Foundation

struct SignInAction: Encodable {
    
    var parameters: SignInRequest
    
    func call(completion: @escaping (SignInResponse?) -> Void) {
        
        let scheme: String = "http"
        let host: String = "localhost"
        let port: Int = 8189
        let path = "/api/auth/login"

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
                let response = try? JSONDecoder().decode(SignInResponse.self, from: data)
                
                if let response = response {
                    completion(response)
                } else {
                    // Error: Unable to decode response JSON
                    completion(nil)
                }
            } else {
                // Error: API request failed
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                completion(nil)
            }
        }
        task.resume()
    }
}

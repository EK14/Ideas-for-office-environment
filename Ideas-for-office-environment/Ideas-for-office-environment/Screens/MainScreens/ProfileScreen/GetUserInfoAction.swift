//
//  GetUserInfoAction.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 23.04.2024.
//

import Foundation

struct GetUserInfoAction: Encodable {
    
    func call(completion: @escaping (Result<UserInfoResponse, NetworkError>) -> Void) {
        let token = Auth.shared.getAccessToken()
        
        let scheme: String = "http"
        let host: String = "localhost"
        let port: Int = 8189
        let path = "/api/auth/user-info"

        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        components.path = path
        
        guard let url = components.url else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "get"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let response = try? JSONDecoder().decode(UserInfoResponse.self, from: data)
                
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

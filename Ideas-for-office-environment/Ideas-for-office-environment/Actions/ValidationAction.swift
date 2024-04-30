//
//  ValidationAction.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 10.04.2024.
//

import Foundation

struct ValidationAction {
    
    func call(email: String, completion: @escaping (Result<Any?, NetworkError>) -> Void) {
        let scheme: String = "http"
        let host: String = "localhost"
        let port: Int = 8189
        let path = "/api/auth/email-valid"
        let queryItems = [URLQueryItem(name: "email", value: "\(email)")]

        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "get"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Response: No Response")
                return
            }

            switch httpResponse.statusCode {
            case 200:
                // Handle successful response
                DispatchQueue.main.async {
                    completion(.success(nil))
                }
            case 400:
                // Handle bad request error
                DispatchQueue.main.async {
                    completion(.failure(.emailNotValid))
                }
            default:
                // Handle other status codes
                print("Response: Unexpected Status Code \(httpResponse.statusCode)")
            }
        }
        task.resume()
    }
}

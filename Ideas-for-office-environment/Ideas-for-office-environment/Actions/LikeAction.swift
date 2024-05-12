//
//  LikeAction.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 12.05.2024.
//

import Foundation

struct LikeAction {
    
    func call(postId: Int, requestType: NetworkRequestType, completion: @escaping (Result<Any?, NetworkError>) -> Void) {
        let token = Auth.shared.getAccessToken()
        let scheme: String = "http"
        let host: String = "localhost"
        let port: Int = 8189
        let path = "/api/posts/\(postId)/like"
        
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        components.path = path
        
        guard let url = components.url else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        
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

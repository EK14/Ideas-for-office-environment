//
//  GetPostsAction.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 10.05.2024.
//

import Foundation

struct GetPostsAction {
    
    func call(office: [Int], search: String?, sortingFilter: Int?, page: Int, completion: @escaping (Result<Any?, NetworkError>) -> Void) {
        let pageSize = 10
        let token = Auth.shared.getAccessToken()
        
        let scheme: String = "http"
        let host: String = "localhost"
        let port: Int = 8189
        let path = "/api/posts"
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "office", value: office.map { String($0) }.joined(separator: ",")),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "page_size", value: "\(pageSize)")
        ]

        if let search = search {
            queryItems.append(URLQueryItem(name: "search", value: search))
        } else {
            queryItems.append(URLQueryItem(name: "search", value: ""))
        }

        if let sortingFilter = sortingFilter {
            queryItems.append(URLQueryItem(name: "sorting_filter", value: "\(sortingFilter)"))
        } else {
            queryItems.append(URLQueryItem(name: "sorting_filter", value: ""))
        }

        print(path)
//        var queryItems = [URLQueryItem(name: "office", value: "\(office)"),
//                          URLQueryItem(name: "page", value: "\(page)"),
//                          URLQueryItem(name: "page_size", value: "\(pageSize)")]
//        
////        if let search = search {
////            queryItems.append(URLQueryItem(name: "search", value: "\(search)"))
////        }
////        
////        if let sortingFilter = sortingFilter {
////            queryItems.append(URLQueryItem(name: "sorting_filter", value: "\(sortingFilter)"))
////        }
//        
//        queryItems.append(URLQueryItem(name: "search", value: ""))
//        
//        queryItems.append(URLQueryItem(name: "sorting_filter", value: ""))

        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            return
        }
        
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let response = try? JSONDecoder().decode([IdeaPostResponse].self, from: data)
                
                if let response = response {
                    DispatchQueue.main.async {
                        completion(.success(response))
                    }
                } else {
                    // Error: Unable to decode response JSON
                    print("Unable to decode response JSON")
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

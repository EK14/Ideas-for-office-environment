//
//  UploadImageAction.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 30.04.2024.
//

import UIKit

class UploadImageAction {
    func call(image: UIImage, completion: @escaping (String) -> ()) {
        let base64Image = image.base64
        let clientID = "c2dfea4ef4fa0fc"
        let boundary = "Boundary-\(UUID().uuidString)"
        
        var request = URLRequest(url: URL(string: "https://api.imgur.com/3/image")!)
        request.addValue("Client-ID \(clientID)", forHTTPHeaderField: "Authorization")
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        
        var body = ""
        body += "--\(boundary)\r\n"
        body += "Content-Disposition:form-data; name=\"image\""
        body += "\r\n\r\n\(base64Image ?? "")\r\n"
        body += "--\(boundary)--\r\n"
        let postData = body.data(using: .utf8)
        
        request.httpBody = postData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("failed with error: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                print("server error")
                return
            }
            if let mimeType = response.mimeType, mimeType == "application/json", let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("imgur upload results: \(dataString)")
                
                let parsedResult: [String: AnyObject]
                do {
                    parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: AnyObject]
                    if let dataJson = parsedResult["data"] as? [String: Any] {
                        if let url = dataJson["link"] as? String {
                            completion(url)
                        } else {
                            print("Link not found")
                        }
                    }
                } catch {
                    // Display an error
                }
            }
        }
        .resume()
    }
}

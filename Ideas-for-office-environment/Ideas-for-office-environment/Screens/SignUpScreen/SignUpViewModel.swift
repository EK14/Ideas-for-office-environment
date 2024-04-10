//
//  SignUpViewModel.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 07.04.2024.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordRepeate: String = ""
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var job: String = ""
    @Published var photo: String? = nil
    @Published var office: Int = .zero
    @Published var offices = [Office]()
    @Published var emailNotValid = false
    
    init() {
        fetchOfficesData { [weak self] response in
            switch response {
            case .success(let data):
                self?.offices = data + data
            case .failure(_):
                print("Could not fetch offices")
            }
        }
    }
    
    func signUp() {
        SignUpAction(
            parameters: SignUpRequest(
                email: self.email,
                password: self.password,
                userInfo: UserDto(name: self.name,
                                  surname: self.surname,
                                  job: self.job,
                                  photo: self.photo,
                                  office: self.office))).call { response in
                                      
                                  }
    }
    
    func fetchOfficesData(completion: @escaping (Result<[Office], NetworkError>) -> Void){
        let scheme: String = "http"
        let host: String = "localhost"
        let port: Int = 8189
        let path = "/api/users/offices"

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
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let response = try? JSONDecoder().decode([Office].self, from: data)
                
                if let response = response {
                    DispatchQueue.main.async {
                        completion(.success(response))
                    }
                } else {
                    // Error: Unable to decode response JSON
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
    
    func checkEmailValidation(completion: @escaping () -> Void) {
        ValidationAction().call(email: email) { [weak self] result in
            switch result {
            case .success(_):
                self?.emailNotValid = false
                completion()
            case .failure(_):
                self?.emailNotValid = true
                completion()
            }
        }
    }
}

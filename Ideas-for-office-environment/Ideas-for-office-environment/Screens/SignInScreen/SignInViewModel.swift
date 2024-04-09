//
//  SignInViewModel.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 03.04.2024.
//

import Foundation

class SignInViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var wrongUser: Bool = false
    
    func signIn() {
        SignInAction(
            parameters: SignInRequest(
                email: email,
                password: password
            )
        ).call { response in
            switch response {
            case .success(let response):
                Auth.shared.setCredentials(
                    accessToken: response.accessToken,
                    refreshToken: response.refreshToken
                )
            case .failure(_):
                self.wrongUser = true
            }
        }
    }
    
    func signUp() {
        
    }
}

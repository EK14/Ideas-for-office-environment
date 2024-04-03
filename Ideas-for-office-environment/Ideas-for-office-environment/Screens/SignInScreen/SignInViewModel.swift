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
    
    func signIn() {
        SignInAction(
            parameters: SignInRequest(
                email: email,
                password: password
            )
        ).call { _ in
            // Login successful, navigate to the Home screen
        }
    }
}

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
    @Published var passwordRepete: String = ""
}

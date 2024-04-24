//
//  SignInRequest.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 03.04.2024.
//

import Foundation

struct SignInRequest: Encodable {
    let email: String
    let password: String
}

//
//  SignInResponse.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 03.04.2024.
//

import Foundation

struct SignInResponse: Decodable {
    let accessToken: String
    let refreshToken: String
}

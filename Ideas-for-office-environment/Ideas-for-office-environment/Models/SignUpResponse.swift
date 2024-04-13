//
//  SignUpResponse.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 13.04.2024.
//

import Foundation

struct SignUpResponse: Decodable {
    let accessToken: String
    let refreshToken: String
}

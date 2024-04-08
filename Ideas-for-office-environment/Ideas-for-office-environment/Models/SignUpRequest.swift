//
//  SignUpRequest.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 07.04.2024.
//

import Foundation

struct SignUpRequest: Encodable {
    let email: String
    let password: String
    let userInfo: UserDto
}

struct UserDto: Encodable {
    let name: String
    let surname: String
    let job: String
    let photo: String? = nil
    let office: Int
}

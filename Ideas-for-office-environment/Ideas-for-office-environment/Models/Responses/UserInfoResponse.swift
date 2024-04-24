//
//  UserInfoResponse.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 23.04.2024.
//

import Foundation

struct UserInfoResponse: Decodable {
    let id: Int
    let name: String
    let surname: String
    let email: String
    let job: String
    let photo: String
    let office: Office
}

//
//  IdeaPostResponse.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 03.05.2024.
//

import Foundation

struct IdeaPostResponse: Decodable {
    let id: Int
    let title: String
    let content: String
}

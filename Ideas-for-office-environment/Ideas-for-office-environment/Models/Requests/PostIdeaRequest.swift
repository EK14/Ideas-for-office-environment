//
//  PostIdeaRequest.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 11.05.2024.
//

import Foundation

struct PostIdeaRequest: Encodable {
    let title: String
    let content: String
    let attachedImages: [String]
}

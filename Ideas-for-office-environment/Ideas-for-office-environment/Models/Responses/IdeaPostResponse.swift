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
    let date: String
    let ideaAuthor: IdeaAuthor
    let attachedImages: [String]
    let office: Office
    let likesCount: Int
    let isLikePressed: Bool
    let dislikesCount: Int
    let isDislikePressed: Bool
    let commentsCount: Int
    let isSuggestedToMyOffice: Bool
}

struct IdeaAuthor: Decodable {
    let id: Int
    let name: String
    let surname: String
    let job: String
    let photo: String
    let office: Office
}

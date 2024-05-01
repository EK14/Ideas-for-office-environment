//
//  SuggestIdeaViewModel.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 01.05.2024.
//

import SwiftUI

struct Post: Identifiable {
    let id = UUID()
    let image: Image
}

class SuggestIdeaViewModel: ObservableObject {
    @Published var posts = [Post]()

    func deletePhoto(post: Post) {
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            posts.remove(at: index)
        }
    }
}

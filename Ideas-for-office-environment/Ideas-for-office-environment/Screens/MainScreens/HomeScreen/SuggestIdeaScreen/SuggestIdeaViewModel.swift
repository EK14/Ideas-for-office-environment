//
//  SuggestIdeaViewModel.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 01.05.2024.
//

import SwiftUI

struct Post: Identifiable {
    let id = UUID()
    let image: UIImage
}

class SuggestIdeaViewModel: ObservableObject {
    @Published var posts = [Post]()
    @Published var postId: Int?
    @Published var title = ""
    @Published var content = ""
    @Published var attachedImages = [String]()
    @Published var isLoading = false
    @ObservedObject var parentViewModel: HomeViewModel
    
    init(parentViewModel: HomeViewModel, postId: Int? = nil) {
        self.parentViewModel = parentViewModel
        self.postId = postId
        
    }

    func deletePhoto(post: Post) {
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            posts.remove(at: index)
        }
    }
    
    func suggestIdea(completion: @escaping () -> ()) {
        isLoading = true
        uploadImages {
            PostIdeaPostAction(parameters: PostIdeaRequest(title: self.title, content: self.content, attachedImages: self.attachedImages)).call() { result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self.parentViewModel.refresh() {
                            completion()
                        }
                    }
                case .failure(_):
                    print("Error fetching user info")
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            }
        }
    }
    
    func editIdea(completion: @escaping () -> ()) {
        isLoading = true
        guard let postId else { return }
        uploadImages {
            EditPostAction(parameters: PostIdeaRequest(title: self.title, content: self.content, attachedImages: self.attachedImages)).call(postId: postId) { result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self.parentViewModel.refresh() {
                            completion()
                        }
                    }
                case .failure(_):
                    print("Error fetching user info")
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            }
        }
    }
    
    func uploadImages(completion: @escaping () -> ()) {
        let group = DispatchGroup()

        for index in 0..<posts.count {
            group.enter()

            UploadImageAction().call(image: posts[index].image) { [weak self] photoUrl in
                DispatchQueue.main.async {
                    self?.attachedImages.append(photoUrl)
                    group.leave()
                }
            }
        }

        group.notify(queue: .main) {
            completion()
        }
    }

}

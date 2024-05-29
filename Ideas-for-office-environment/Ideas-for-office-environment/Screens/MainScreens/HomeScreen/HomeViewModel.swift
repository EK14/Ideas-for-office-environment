//
//  HomeViewModel.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 30.04.2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var posts = [IdeaPostResponse]()
    @Published var searchText: String = ""
    @Published var page = 0
    @Published var selectedOffices: Set<Int> = []
    @Published var userId = 0
    @Published var isLoading = false
    @Published var isDeletingPost = false
    @Published var isSettingDislike = false
    @Published var isRemovingDislike = false
    @Published var isSettingLike = false
    @Published var isRemovingLike = false
    @Published var didReachedLastPost = false
    
//    init() {
//        getUserInfo() {
//            self.isLoading = true
//            self.getPosts {
//                self.isLoading = false
//            }
//            self.page += 1
//        }
//    }
    
    //MARK: - PAGINATION
    func loadMoreContent(currentPost item: IdeaPostResponse){
        guard posts.count > 0 else { return }
        if posts[posts.count - 1].id == item.id {
            self.didReachedLastPost = true
            page += 1
            getPosts {
                self.didReachedLastPost = false
            }
        }
    }

    func getPosts(completion: @escaping () -> ()) {
//        isLoading = true
        GetPostsAction().call(office: selectedOffices, search: nil, sortingFilter: nil, page: self.page) { [weak self] result in
            switch result {
            case .success(let info):
                DispatchQueue.main.async {
//                    self?.posts = info
                    for post in info {
                        self?.posts.append(post)
                    }
//                    self?.isLoading = false
                    completion()
                }
            case .failure(_):
                print("Error fetching user info")
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func getUserInfo(completion: @escaping () -> ()) {
        isLoading = true
        GetUserInfoAction().call { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.selectedOffices.insert(success.office.id)
                    self.userId = success.id
                    self.isLoading = false
                    completion()
                }
            case .failure(_):
                print("Error getting userInfo")
            }
        }
    }
    
    func hasReachedEnd() {
        
    }
    
    func refresh(completion: @escaping () -> ()) {
        page = 1
        DispatchQueue.main.async {
            self.posts = []
        }
        DispatchQueue.main.async {
            self.getPosts {
                completion()
            }
        }
    }
    
    func setLike(postId: Int, completion: @escaping () -> ()) {
        guard !isSettingLike else { return }
        isSettingLike = true
        LikeDislikeAction().call(postId: postId, requestType: .post, action: .like) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.isSettingLike = false
                }
                completion()
                print("successfully set like")
            case .failure(_):
                print("Error setting like")
            }
        }
    }
    
    func removeLike(postId: Int, completion: @escaping () -> ()) {
        guard !isRemovingLike else { return }
        isRemovingLike = true
        LikeDislikeAction().call(postId: postId, requestType: .delete, action: .like) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.isRemovingLike = false
                }
                completion()
                print("successfully remove like")
            case .failure(_):
                print("Error removing like")
            }
        }
    }
    
    func setDislike(postId: Int, completion: @escaping () -> ()) {
        guard !isSettingDislike else { return }
        isSettingDislike = true
        LikeDislikeAction().call(postId: postId, requestType: .post, action: .dislike) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.isSettingDislike = false
                }
                completion()
                print("successfully set like")
            case .failure(_):
                print("Error setting like")
            }
        }
    }
    
    func removeDislike(postId: Int, completion: @escaping () -> ()) {
        guard !isRemovingDislike else { return }
        isRemovingDislike = true
        LikeDislikeAction().call(postId: postId, requestType: .delete, action: .dislike) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.isRemovingDislike = false
                }
                completion()
                print("successfully remove like")
            case .failure(_):
                print("Error removing like")
            }
        }
    }
    
    func deletePost(postId: Int) {
        isDeletingPost = true
        if let index = posts.firstIndex(where: { $0.id == postId }) {
            posts.remove(at: index)
        }
        DeletePostAction().call(postId: postId) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.isDeletingPost = false
                }
                print("successfully delete post")
            case .failure(_):
                print("Error deleting post")
            }
        }
    }
}

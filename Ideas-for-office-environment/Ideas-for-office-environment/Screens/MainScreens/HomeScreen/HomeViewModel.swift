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
    @Published var page = 1

    func getPosts(completion: @escaping () -> ()) {
        GetUserInfoAction().call { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let userInfo):
                DispatchQueue.main.async {
                    GetPostsAction().call(office: [userInfo.office.id], search: nil, sortingFilter: nil, page: self.page) { [weak self] result in
                        switch result {
                        case .success(let info):
                            DispatchQueue.main.async {
                                for post in info {
                                    self?.posts.append(post)
                                }
                                self?.page += 1
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
            case .failure(_):
                print("Error fetching user info")
            }
        }
    }
    
    func loadMore() {
        getPosts {
            print("done")
        }
    }
}

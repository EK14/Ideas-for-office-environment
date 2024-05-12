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
    @Published var selectedOffices: [Int] = []
    
    init() {
        GetUserInfoAction().call { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.selectedOffices.append(success.office.id)
                    self.refresh()
                }
            case .failure(_):
                print("Error getting userInfo")
            }
        }
    }

    func getPosts(completion: @escaping () -> ()) {
        GetPostsAction().call(office: selectedOffices, search: nil, sortingFilter: nil, page: self.page) { [weak self] result in
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
    
    func refresh() {
        page = 1
        posts.removeAll()
        getPosts {}
    }
}

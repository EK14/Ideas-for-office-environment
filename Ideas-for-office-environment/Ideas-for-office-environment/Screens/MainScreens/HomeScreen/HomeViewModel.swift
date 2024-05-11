//
//  HomeViewModel.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 30.04.2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var posts = [IdeaPostResponse]()

    func getPosts(completion: @escaping () -> ()) {
        GetUserInfoAction().call { [weak self] result in
            switch result {
            case .success(let userInfo):
                DispatchQueue.main.async {
                    GetPostsAction().call(office: [userInfo.office.id], search: nil, sortingFilter: nil, page: 1) { [weak self] result in
                        switch result {
                        case .success(let info):
                            DispatchQueue.main.async {
                                self?.posts = info as! [IdeaPostResponse]
                                print(self?.posts)
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
}

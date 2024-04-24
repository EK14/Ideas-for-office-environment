//
//  ProfileViewModel.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 23.04.2024.
//

import Foundation
import SDWebImageSwiftUI

class ProfileViewModel: ObservableObject {
    @Published var photo: String? = nil
    @Published var name = ""
    @Published var position = ""
    @Published var isLoading = false
    
    func getUserInfo(completion: @escaping () -> ()) {
        isLoading = true
        GetUserInfoAction().call { [weak self] result in
            switch result {
            case .success(let userInfo):
                DispatchQueue.main.async {
                    self?.photo = userInfo.photo
                    self?.name = "\(userInfo.name) \(userInfo.surname)"
                    self?.position = userInfo.job
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
}

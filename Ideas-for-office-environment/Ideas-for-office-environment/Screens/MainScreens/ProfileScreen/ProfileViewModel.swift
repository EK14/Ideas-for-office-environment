//
//  ProfileViewModel.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 23.04.2024.
//

import Foundation
import SDWebImageSwiftUI

class ProfileViewModel: ObservableObject {
    @Published var photo = ""
    @Published var name = ""
    @Published var surname = ""
    @Published var job = ""
    @Published var office = Office(id: 0, imageUrl: "", address: "")
    @Published var isLoading = false
    
    func getUserInfo(completion: @escaping () -> ()) {
        isLoading = true
        GetUserInfoAction().call { [weak self] result in
            switch result {
            case .success(let userInfo):
                DispatchQueue.main.async {
                    self?.photo = userInfo.photo
                    self?.name = userInfo.name
                    self?.surname = userInfo.surname
                    self?.job = userInfo.job
                    self?.office = userInfo.office
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
    
    func saveUserInfo(completion: @escaping () -> ()) {
        print(UserDto(name: name,
                      surname: surname,
                      job: job,
                      photo: "",
                      office: office.id))
        SaveUserInfoAction(parameters: UserDto(name: name,
                                               surname: surname,
                                               job: job,
                                               photo: "",
                                               office: office.id)).call { result in
            switch result {
            case .success(let success):
                print("success")
            case .failure(let failure):
                print("failure")
            }
            completion()
        }
    }
}

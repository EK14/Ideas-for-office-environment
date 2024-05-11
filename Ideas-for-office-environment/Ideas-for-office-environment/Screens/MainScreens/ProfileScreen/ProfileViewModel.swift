//
//  ProfileViewModel.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 23.04.2024.
//

import Foundation
import SDWebImageSwiftUI

class ProfileViewModel: CarousalViewContainerViewModel {
    @Published var photoUrl = ""
    @Published var name = ""
    @Published var surname = ""
    @Published var job = ""
    @Published var office: Int = .zero
    @Published var offices = [Office]()
    @Published var photo: UIImage?
    @Published var isLoading = false
    
    func getUserInfo(completion: @escaping () -> ()) {
        isLoading = true
        GetUserInfoAction().call { [weak self] result in
            switch result {
            case .success(let userInfo):
                DispatchQueue.main.async {
                    self?.photoUrl = userInfo.photo
                    self?.name = userInfo.name
                    self?.surname = userInfo.surname
                    self?.job = userInfo.job
                    self?.office = userInfo.office.id
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
        isLoading = true
        if let photo = photo {
            UploadImageAction().call(image: photo) { photoUrl in
                SaveUserInfoAction(parameters: UserDto(name: self.name,
                                                       surname: self.surname,
                                                       job: self.job,
                                                       photo: photoUrl,
                                                       office: self.office)).call { result in
                    switch result {
                    case .success(_):
                        print("success")
                    case .failure(_):
                        print("failure")
                    }
                    completion()
                }
            }
        }
    }
    
    func fetchOffices(completion: @escaping () -> ()) {
        isLoading = true
        FetchOfficesAction().call { [weak self] response in
            switch response {
            case .success(let data):
                self?.offices = data + data
            case .failure(_):
                print("Could not fetch offices")
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}

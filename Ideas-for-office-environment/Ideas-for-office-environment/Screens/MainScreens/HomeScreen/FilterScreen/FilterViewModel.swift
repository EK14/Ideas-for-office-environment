//
//  FilterViewModel.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 10.05.2024.
//

import SwiftUI

class FilterViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var offices = [Office]()
    @Published var office: Int = .zero
    @Published var selectedOffices: [Int] = []
    @ObservedObject var parentViewModel: HomeViewModel
    
    init(parentViewModel: HomeViewModel) {
        self.parentViewModel = parentViewModel
    }
    
    func fetchOffices(completion: @escaping () -> ()) {
        isLoading = true
        FetchOfficesAction().call { [weak self] response in
            switch response {
            case .success(let data):
                self?.objectWillChange.send()
                self?.offices = data
            case .failure(_):
                print("Could not fetch offices")
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func getUserInfo(completion: @escaping () -> ()) {
        isLoading = true
        GetUserInfoAction().call { [weak self] result in
            switch result {
            case .success(let userInfo):
                DispatchQueue.main.async {
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
    
    func applyFilters() {
        DispatchQueue.main.async {
            self.parentViewModel.selectedOffices = self.selectedOffices
            self.parentViewModel.refresh()
        }
    }
}

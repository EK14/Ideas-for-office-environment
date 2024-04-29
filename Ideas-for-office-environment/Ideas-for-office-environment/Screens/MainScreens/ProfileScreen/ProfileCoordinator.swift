//
//  ProfileCoordinator.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 20.03.2024.
//

import SwiftUI

class ProfileCoordinator: Coordinator {
    
    var rootViewController = UINavigationController()
    var viewModel = SignUpViewModel()
    var profileViewModel = ProfileViewModel()
    
    lazy var ProfileVC: UIHostingController = {
        var vc = UIHostingController(rootView: ProfileView(viewModel: profileViewModel, coordinator: self))
        return vc
    }()
    
    lazy var setupProfileCoordinator: SetUpProfileCoordinator = {
        var coordinator = SetUpProfileCoordinator(navigationController: rootViewController, setupProfileViewModel: profileViewModel)
        return coordinator
    }()
    
    func start() {
        rootViewController.setViewControllers([ProfileVC], animated: true)
    }
    
    func setupProfile() {
        setupProfileCoordinator.start()
    }
}

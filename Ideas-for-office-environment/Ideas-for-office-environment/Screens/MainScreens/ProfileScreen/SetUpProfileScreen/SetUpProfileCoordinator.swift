//
//  SetUpProfileCoordinator.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 29.04.2024.
//

import SwiftUI

class SetUpProfileCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var setupProfileViewModel: ProfileViewModel

    init(navigationController: UINavigationController, setupProfileViewModel: ProfileViewModel) {
        self.navigationController = navigationController
        self.setupProfileViewModel = setupProfileViewModel
    }
    
    func start() {
        let view = SetUpProfileView(viewModel: SignUpViewModel(), setupProfileViewModel: setupProfileViewModel)
        let hostingController = UIHostingController(rootView: view)
        navigationController.pushViewController(hostingController, animated: true)
    }
}

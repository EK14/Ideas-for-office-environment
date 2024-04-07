//
//  SignUpCoordinator.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 17.03.2024.
//

import SwiftUI

class SignUpCoordinator: Coordinator {
    
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let view = SignUpView(coordinator: self)
        let hostingController = UIHostingController(rootView: view)
        navigationController.pushViewController(hostingController, animated: true)
    }

    func navigateToSignUpNextView() {
        let signUpNextViewCoordinator = SignUpNextViewCoordinator()
        signUpNextViewCoordinator.start()
        navigationController.pushViewController(signUpNextViewCoordinator.rootViewController, animated: true)
    }
    
    func navigateToSignInView() {
        navigationController.popViewController(animated: true)
    }
}

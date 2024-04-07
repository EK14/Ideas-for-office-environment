//
//  SignInCoordinator.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 20.03.2024.
//

import SwiftUI
import Combine

class SignInCoordinator: Coordinator {
    
    var rootViewController = UINavigationController()
    
    lazy var SignInVC: UIHostingController = {
        var vc = UIHostingController(rootView: SignInView(coordinator: self))
        return vc
    }()
    
    func start() {
        rootViewController = UINavigationController(rootViewController: SignInVC)
    }
    
    func navigateToSignUp() {
        let signUpCoordinator = SignUpCoordinator(navigationController: rootViewController)
        signUpCoordinator.start()
    }
    
    @objc func popViewController() {
        rootViewController.popViewController(animated: true)
    }
}

//
//  SignInCoordinator.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 20.03.2024.
//

import SwiftUI
import Combine

class SignInCoordinator: Coordinator {
    
    var rootViewController = UIViewController()
    
    var childCoordinator = SignUpCoordinator()
    
    func start() {
        let view = SignInView(coordinator: self)
        rootViewController = UIHostingController(rootView: view)
    }
    
    func navigateToSignUp() {
        
    }
}

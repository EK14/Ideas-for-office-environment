//
//  SignUpCoordinator.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 17.03.2024.
//

import SwiftUI

class SignUpCoordinator: Coordinator {
    
    var rootViewController = UIViewController()
    
    func start() {
        let view = SignUpView()
        rootViewController = UIHostingController(rootView: view)
    }
}

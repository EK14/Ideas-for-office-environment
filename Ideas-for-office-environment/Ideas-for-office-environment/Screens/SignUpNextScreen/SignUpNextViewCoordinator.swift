//
//  SignUpNextViewCoordinator.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 07.04.2024.
//

import SwiftUI

class SignUpNextViewCoordinator: Coordinator {
    
    var rootViewController = UIViewController()
    
    func start() {
        rootViewController = UIHostingController(rootView: SignUpNextView())
    }
}

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
    
//    var hasLoggedIn: CurrentValueSubject<Bool, Never>
    
//    init(hasLoggedIn: CurrentValueSubject<Bool, Never>) {
//        self.hasLoggedIn = hasLoggedIn
//    }
    
    func start() {
//        let view = SignInView { [weak self] in
////            self?.hasLoggedIn.send(true)
//            Aut
//        }
        let view = SignInView()
        rootViewController = UIHostingController(rootView: view)
    }
}

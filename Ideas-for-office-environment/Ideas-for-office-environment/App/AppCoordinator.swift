//
//  AppCoordinator.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 17.03.2024.
//

import SwiftUI
import Combine

class AppCoordinator: Coordinator {
    
    var window: UIWindow
    
    var childCoordinators = [Coordinator]()
    
    let hasLoggedIn = Auth.shared.loggedIn
    
    var subscriptions = Set<AnyCancellable>()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        hasLoggedIn
            .removeDuplicates()
            .sink { [weak self] hasLoggedIn in
                if hasLoggedIn {
                    DispatchQueue.main.async {
                        let mainCoordinator = MainCoordinator()
                        mainCoordinator.start()
                        self?.childCoordinators = [mainCoordinator]
                        self?.window.rootViewController = mainCoordinator.rootViewController
                    }
                } else {
                    let signInCoordinator = SignInCoordinator()
                    signInCoordinator.start()
                    self?.childCoordinators = [signInCoordinator]
                    self?.window.rootViewController = signInCoordinator.rootViewController
                }
            }
            .store(in: &subscriptions)
    }
}

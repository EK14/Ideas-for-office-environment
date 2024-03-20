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
    
    let hasLoggedIn = CurrentValueSubject<Bool, Never>(false)
    
    var subscriptions = Set<AnyCancellable>()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
//        setUpLogInValue()
        
        hasLoggedIn
            .removeDuplicates()
            .sink { [weak self] hasLoggedIn in
                if hasLoggedIn {
                    let mainCoordinator = MainCoordinator()
                    mainCoordinator.start()
                    self?.childCoordinators = [mainCoordinator]
                    self?.window.rootViewController = mainCoordinator.rootViewController
                } else if let loggedIn = self?.hasLoggedIn {
                    let signInCoordinator = SignInCoordinator(hasLoggedIn: loggedIn)
                    signInCoordinator.start()
                    self?.childCoordinators = [signInCoordinator]
                    self?.window.rootViewController = signInCoordinator.rootViewController
                }
            }
            .store(in: &subscriptions)
    }
    
    func setUpLogInValue() {
        let key = "hasLoggedIn"
        let value = UserDefaults.standard.bool(forKey: key)
        hasLoggedIn.send(value)
        
        hasLoggedIn
            .filter { $0 }
            .sink { value in
                UserDefaults.standard.setValue(value, forKey: key)
            }
            .store(in: &subscriptions)
    }
}

//
//  ProfileCoordinator.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 20.03.2024.
//

import SwiftUI

class ProfileCoordinator: Coordinator {
    
    var rootViewController = UINavigationController()
    
    lazy var ProfileVC: UIHostingController = {
        var vc = UIHostingController(rootView: ProfileView())
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([ProfileVC], animated: true)
    }
}

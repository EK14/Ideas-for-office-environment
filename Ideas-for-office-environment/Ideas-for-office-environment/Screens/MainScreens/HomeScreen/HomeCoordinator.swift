//
//  HomeCoordinator.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 17.03.2024.
//

import SwiftUI

class HomeCoordinator: Coordinator {
    
    var rootViewController = UINavigationController()
    
    lazy var homeVC: UIHostingController = {
        var vc = UIHostingController(rootView: HomeView())
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([homeVC], animated: true)
    }
}

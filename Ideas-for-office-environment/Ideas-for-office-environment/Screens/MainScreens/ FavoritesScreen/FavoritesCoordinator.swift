//
//  FavoritesCoordinator.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 17.03.2024.
//

import SwiftUI

class FavoritesCoordinator: Coordinator {
    
    var rootViewController = UINavigationController()
    
    lazy var favoritesVC: UIHostingController = {
        var vc = UIHostingController(rootView: FavoritesView())
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([favoritesVC], animated: false)
    }
}

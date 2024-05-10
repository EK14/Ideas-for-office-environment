//
//  FilterCoordinator.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 10.05.2024.
//

import SwiftUI

class FilterCoordinator: Coordinator {
    
    var rootViewController: UINavigationController
    
    lazy var filterVC: UIHostingController = {
        var vc = UIHostingController(rootView: FilterView(coordinator: self))
        return vc
    }()
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        rootViewController.pushViewController(filterVC, animated: true)
    }
    
    func applyFilters() {
        rootViewController.popViewController(animated: true)
    }
}

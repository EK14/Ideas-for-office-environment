//
//  MyOfficeCoordinator.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 20.03.2024.
//

import SwiftUI

class MyOfficeCoordinator: Coordinator {
    
    var rootViewController = UINavigationController()
    
    lazy var MyOfficeVC: UIHostingController = {
        var vc = UIHostingController(rootView: MyOfficeView())
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([MyOfficeVC], animated: true)
    }
}

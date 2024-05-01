//
//  SuggestIdeaCoordinator.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 30.04.2024.
//

import SwiftUI

class SuggestIdeaCoordinator: Coordinator {
    
    var rootViewController: UINavigationController
    
    lazy var suggestIdeaView: UIHostingController = {
        var vc = UIHostingController(rootView: SuggestIdeaView(coordinator: self))
        return vc
    }()
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        rootViewController.present(suggestIdeaView, animated: true)
    }
    
    func close() {
        rootViewController.dismiss(animated: true)
    }
}

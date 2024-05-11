//
//  SuggestIdeaCoordinator.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 30.04.2024.
//

import SwiftUI

class SuggestIdeaCoordinator: Coordinator {
    
    var rootViewController: UINavigationController
    
    @ObservedObject var parentViewModel: HomeViewModel
    @ObservedObject var viewModel: SuggestIdeaViewModel
    
    lazy var suggestIdeaView: UIHostingController = {
        var vc = UIHostingController(rootView: SuggestIdeaView(coordinator: self, viewModel: viewModel))
        return vc
    }()
    
    init(rootViewController: UINavigationController, parentViewModel: HomeViewModel) {
        self.rootViewController = rootViewController
        self.parentViewModel = parentViewModel
        viewModel = SuggestIdeaViewModel(parentViewModel: parentViewModel)
    }
    
    func start() {
        rootViewController.present(suggestIdeaView, animated: true)
    }
    
    func close() {
        rootViewController.dismiss(animated: true)
    }
}

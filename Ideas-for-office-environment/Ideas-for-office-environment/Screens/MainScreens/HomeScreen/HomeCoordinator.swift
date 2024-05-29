//
//  HomeCoordinator.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 17.03.2024.
//

import SwiftUI

class HomeCoordinator: Coordinator {
    
    var rootViewController = UINavigationController()
    
    @ObservedObject var viewModel = HomeViewModel()
    
    lazy var homeVC: UIHostingController = {
        var vc = UIHostingController(rootView: HomeView(viewModel: viewModel, coordinator: self))
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([homeVC], animated: true)
    }
    
    func createNewIdea() {
        let suggestIdeaCoordinator = SuggestIdeaCoordinator(rootViewController: rootViewController, parentViewModel: viewModel)
        suggestIdeaCoordinator.start()
    }
    
    func editPost(postId: Int) {
        let suggestIdeaCoordinator = SuggestIdeaCoordinator(rootViewController: rootViewController, parentViewModel: viewModel, postId: postId)
        suggestIdeaCoordinator.start()
    }
    
    func addFilters() {
        let filterCoordinator = FilterCoordinator(rootViewController: rootViewController, parentViewModel: viewModel)
        filterCoordinator.start()
    }
}

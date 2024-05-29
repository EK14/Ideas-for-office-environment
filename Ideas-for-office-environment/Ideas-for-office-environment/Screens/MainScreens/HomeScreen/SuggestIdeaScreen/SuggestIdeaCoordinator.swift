//
//  SuggestIdeaCoordinator.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 30.04.2024.
//

import SwiftUI

class SuggestIdeaCoordinator: Coordinator {
    
    var rootViewController: UINavigationController
    var postId: Int?
    
    @ObservedObject var parentViewModel: HomeViewModel
    @ObservedObject var viewModel: SuggestIdeaViewModel
    
    lazy var suggestIdeaView: UIHostingController = {
        var vc = UIHostingController(rootView: SuggestEditIdeaView(coordinator: self, screenType: .suggest, viewModel: viewModel))
        return vc
    }()
    
    init(rootViewController: UINavigationController, parentViewModel: HomeViewModel, postId: Int? = nil) {
        self.rootViewController = rootViewController
        self.parentViewModel = parentViewModel
        self.postId = postId
        viewModel = SuggestIdeaViewModel(parentViewModel: parentViewModel, postId: postId)
    }
    
    func start() {
        rootViewController.present(suggestIdeaView, animated: true)
    }
    
    func close() {
        rootViewController.dismiss(animated: true)
    }
}

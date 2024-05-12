//
//  FilterCoordinator.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 10.05.2024.
//

import SwiftUI

class FilterCoordinator: Coordinator {
    
    var rootViewController: UINavigationController
    
    @ObservedObject var viewModel: FilterViewModel
    @ObservedObject var parentViewModel: HomeViewModel
    
    lazy var filterVC: UIHostingController = {
        var vc = UIHostingController(rootView: FilterView(viewModel: viewModel, coordinator: self))
        return vc
    }()
    
    init(rootViewController: UINavigationController, parentViewModel: HomeViewModel) {
        self.rootViewController = rootViewController
        self.parentViewModel = parentViewModel
        viewModel = FilterViewModel(parentViewModel: parentViewModel)
    }
    
    func start() {
        rootViewController.pushViewController(filterVC, animated: true)
    }
    
    func applyFilters() {
        rootViewController.popViewController(animated: true)
    }
}

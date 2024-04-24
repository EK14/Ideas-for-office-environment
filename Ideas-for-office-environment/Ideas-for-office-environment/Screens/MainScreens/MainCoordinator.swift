//
//  MainCoordinator.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 17.03.2024.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var rootViewController: UITabBarController
    
    var childCoordinator = [Coordinator]()
    
    init() {
        rootViewController = UITabBarController()
        rootViewController.tabBar.isTranslucent = true
        rootViewController.tabBar.backgroundColor = .white
        rootViewController.tabBar.layer.borderWidth = 1.0
        rootViewController.tabBar.layer.borderColor = UIColor(.gray).cgColor
    }
    
    func start() {
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.start()
        self.childCoordinator.append(homeCoordinator)
        let homeVC = homeCoordinator.rootViewController
        setup(vc: homeVC, title: "Главная", imageName: "house", selectedImageName: "house.fill")
        
        let favoritesCoordinator = FavoritesCoordinator()
        favoritesCoordinator.start()
        self.childCoordinator.append(favoritesCoordinator)
        let favoritesVC = favoritesCoordinator.rootViewController
        setup(vc: favoritesVC, title: "Избранное", imageName: "heart", selectedImageName: "heart.fill")
        
        let myOfficeCoordinator = MyOfficeCoordinator()
        myOfficeCoordinator.start()
        self.childCoordinator.append(myOfficeCoordinator)
        let myOfficeVC = myOfficeCoordinator.rootViewController
        setup(vc: myOfficeVC, title: "Мой офис", imageName: "briefcase", selectedImageName: "briefcase.fill")
        
        let profileCoordinator = ProfileCoordinator()
        profileCoordinator.start()
        self.childCoordinator.append(profileCoordinator)
        let profileVC = profileCoordinator.rootViewController
        setup(vc: profileVC, title: "Профиль", imageName: "person", selectedImageName: "person.fill")
        
        self.rootViewController.viewControllers = [homeVC, favoritesVC, myOfficeVC, profileVC]
    }
    
    func setup(vc: UIViewController, title: String, imageName: String, selectedImageName: String) {
        let defaultImage = UIImage(systemName: imageName)
        let selectedImage = UIImage(systemName: selectedImageName)
        let tabBarItem = UITabBarItem(title: title, image: defaultImage, selectedImage: selectedImage)
        vc.tabBarItem = tabBarItem
    }
}

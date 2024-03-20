//
//  SceneDelegate.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 17.03.2024.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = (scene as? UIWindowScene) {
            let window = UIWindow(windowScene: windowScene)
//            let navigationController = UINavigationController.init()
            let appCoordinator = AppCoordinator(window: window)
            appCoordinator.start()
            self.appCoordinator = appCoordinator
            window.makeKeyAndVisible()
        }
    }
}

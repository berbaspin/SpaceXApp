//
//  SceneDelegate.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 26.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let navigationController = UINavigationController()
        navigationController.navigationBar.barTintColor = .black
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        let assemblyBuilder = AssemblyBuilder()
        let router = Router(assemblyBuilder: assemblyBuilder, navigationController: navigationController)
        router.initializeViewController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}

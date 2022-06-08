//
//  Router.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 31.05.2022.
//

import UIKit

protocol RouterProtocol {
    func initializeViewController()
    func showSettings()
    func showLaunches()
}

final class Router: RouterProtocol {

    private let assemblyBuilder: AssemblyBuilderProtocol
    private let navigationController: UINavigationController

    init(assemblyBuilder: AssemblyBuilderProtocol, navigationController: UINavigationController) {
        self.assemblyBuilder = assemblyBuilder
        self.navigationController = navigationController
    }

    func initializeViewController() {
        let mainViewController = assemblyBuilder.createMainModule()
        navigationController.viewControllers = [mainViewController]
    }

    func showSettings() {
    }

    func showLaunches() {
        let launchesViewController = assemblyBuilder.createLaunchesModule()
        navigationController.pushViewController(launchesViewController, animated: true)
    }
}

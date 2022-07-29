//
//  Router.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 31.05.2022.
//

import UIKit

protocol RouterProtocol {
    func initializeViewController()
    func showSettings(settings: [Setting])
    func showLaunches(rocketName: String, rocketId: String)
    func showMainModule()
}

final class Router: RouterProtocol {

    private let assemblyBuilder: AssemblyBuilderProtocol
    private let navigationController: UINavigationController

    init(assemblyBuilder: AssemblyBuilderProtocol, navigationController: UINavigationController) {
        self.assemblyBuilder = assemblyBuilder
        self.navigationController = navigationController
    }

    func initializeViewController() {
        let mainViewController = assemblyBuilder.createMainModule(router: self)
        navigationController.viewControllers = [mainViewController]
    }

    func showSettings(settings: [Setting]) {
        let settingsViewController = assemblyBuilder.createSettingsModule(router: self)
        let settingNavigationController = UINavigationController(rootViewController: settingsViewController)
        settingNavigationController.modalPresentationStyle = .automatic
        navigationController.topViewController?.present(settingNavigationController, animated: true)
    }

    func showLaunches(rocketName: String, rocketId: String) {
        let launchesViewController = assemblyBuilder.createLaunchesModule(
            rocketName: rocketName,
            rocketId: rocketId
        )
        navigationController.pushViewController(launchesViewController, animated: true)
    }

    func showMainModule() {
        guard let mainViewController = navigationController.topViewController as? MainViewController else {
            return
        }
        mainViewController.viewModel.getData()
        mainViewController.viewWillAppear(true)
    }
}

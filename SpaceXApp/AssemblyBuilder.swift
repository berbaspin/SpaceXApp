//
//  AssemblyBuilder.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 31.05.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createSettingsModule() -> UIViewController
    func createLaunchesModule(rocketName: String, rocketId: String, router: RouterProtocol) -> UIViewController
}

final class AssemblyBuilder: AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let mainViewController = MainViewController()
        let networkManager = NetworkManager()
        let viewModel = MainViewModel(networkManager: networkManager, router: router)
        mainViewController.viewModel = viewModel
        return mainViewController
    }

    func createSettingsModule() -> UIViewController {
        let settingsViewController = SettingsViewController()
        let viewModel = SettingsViewModel()
        settingsViewController.viewModel = viewModel
        return settingsViewController
    }

    func createLaunchesModule(rocketName: String, rocketId: String, router: RouterProtocol) -> UIViewController {
        let launchesViewController = LaunchesViewController()
        let networkManager = NetworkManager()
        let viewModel = LaunchesViewModel(rocketName: rocketName, rocketId: rocketId, networkManager: networkManager)
        launchesViewController.viewModel = viewModel
        return launchesViewController
    }
}

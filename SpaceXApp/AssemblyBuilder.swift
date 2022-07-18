//
//  AssemblyBuilder.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 31.05.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createSettingsModule(settings: [Setting], router: RouterProtocol) -> UIViewController
    func createLaunchesModule(rocketName: String, rocketId: String, router: RouterProtocol) -> UIViewController
}

final class AssemblyBuilder: AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let mainViewController = MainViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)

        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        let networkManager = NetworkManager(decoder: decoder)
        let viewModel = MainViewModel(networkManager: networkManager, router: router)
        mainViewController.viewModel = viewModel
        return mainViewController
    }

    func createSettingsModule(settings: [Setting], router: RouterProtocol) -> UIViewController {
        let settingsViewController = SettingsViewController()
        let viewModel = SettingsViewModel(settings: settings, router: router)
        settingsViewController.viewModel = viewModel
        return settingsViewController
    }

    func createLaunchesModule(rocketName: String, rocketId: String, router: RouterProtocol) -> UIViewController {
        let launchesViewController = LaunchesViewController()
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let networkManager = NetworkManager(decoder: decoder)
        let viewModel = LaunchesViewModel(rocketName: rocketName, rocketId: rocketId, networkManager: networkManager)
        launchesViewController.viewModel = viewModel
        return launchesViewController
    }
}

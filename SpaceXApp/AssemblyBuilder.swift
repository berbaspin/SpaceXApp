//
//  AssemblyBuilder.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 31.05.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule() -> UIViewController
    func createSettingsModule() -> UIViewController
    func createLaunchesModule() -> UIViewController
}

final class AssemblyBuilder: AssemblyBuilderProtocol {
    func createMainModule() -> UIViewController {
        let controller = MainViewController()
        return controller
    }

    func createSettingsModule() -> UIViewController {
        let controller = SettingsViewController()
        return controller
    }

    func createLaunchesModule() -> UIViewController {
        let controller = LaunchesViewController()
        return controller
    }
}

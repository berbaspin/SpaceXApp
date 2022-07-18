//
//  SettingsViewModel.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 30.05.2022.
//

import Foundation
import RxSwift

protocol SettingsViewModelProtocol {
    var dataSource: BehaviorSubject<[Setting]> { get }
    func closeViewController()
}

final class SettingsViewModel: SettingsViewModelProtocol {

    private let router: RouterProtocol
    let dataSource: BehaviorSubject<[Setting]>

    init(settings: [Setting], router: RouterProtocol) {
        self.router = router
        dataSource = BehaviorSubject(value: settings)
    }

    func closeViewController() {
        guard let settings = try? dataSource.value() else {
            return
        }
        router.showMainModule(settings: settings)
    }
}

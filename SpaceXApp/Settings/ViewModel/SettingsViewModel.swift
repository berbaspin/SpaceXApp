//
//  SettingsViewModel.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 30.05.2022.
//

import Foundation
import RxCocoa
import RxSwift

protocol SettingsViewModelProtocol {
    var dataSource: Driver<[Setting]> { get }
    func updateSettings(setting: Setting, isUS: Bool)
    func closeViewController()
}

final class SettingsViewModel: SettingsViewModelProtocol {

    private let router: RouterProtocol
    private let decoder = PropertyListDecoder()
    private let encoder = PropertyListEncoder()
    private let settingsKey = "availableSettings"
    private var settings: [Setting] {
        get {
            guard let savedData = UserDefaults.standard.object(forKey: settingsKey) as? Data,
                let decodedSettings = try? decoder.decode([Setting].self, from: savedData) else {
                return Setting.availableSettings()
            }
            return decodedSettings
        }
        set {
            UserDefaults.standard.set(try? encoder.encode(newValue), forKey: settingsKey)
        }
    }
    private var isSettingsChanged = false

    var dataSource: Driver<[Setting]> {
        Observable.just(settings).asDriver(onErrorDriveWith: .never())
    }

    init(router: RouterProtocol) {
        self.router = router
    }

    func updateSettings(setting: Setting, isUS: Bool) {
        for index in 0 ... settings.count - 1 {
            if settings[index].type == setting.type, settings[index].isUS != isUS {
                isSettingsChanged = true
                settings[index].isUS = isUS
            }
        }
    }

    func closeViewController() {
        router.refreshMainModule(isSettingsChanged: isSettingsChanged)
    }
}

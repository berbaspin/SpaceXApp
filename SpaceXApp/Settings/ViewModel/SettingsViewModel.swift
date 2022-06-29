//
//  SettingsViewModel.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 30.05.2022.
//

import Foundation
import RxSwift

protocol SettingsViewModelProtocol {
    var dataSource: Observable<[Setting]> { get }

}

final class SettingsViewModel: SettingsViewModelProtocol {
    let dataSource = Observable.of(Setting.availableSettings())

    init() {}
}

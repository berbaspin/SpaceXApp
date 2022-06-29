//
//  MainViewModel.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 07.06.2022.
//

import RxSwift
import RxCocoa

protocol MainViewModelProtocol {
    var dataSourse: Driver<[RocketViewModel]> { get }
}

final class MainViewModel: MainViewModelProtocol {

    private let networkManager: NetworkManagerProtocol
    private let router: RouterProtocol

    let dataSourse: Driver<[RocketViewModel]>

    init(networkManager: NetworkManagerProtocol, router: RouterProtocol) {
        self.networkManager = networkManager
        self.router = router

        dataSourse = networkManager.getRockets()
            .map { rockets -> [RocketViewModel] in
                rockets.map { rocket in
                    RocketViewModel(rocket: rocket, router: router)
                }
            }
            .asDriver(onErrorDriveWith: .never())
    }
}

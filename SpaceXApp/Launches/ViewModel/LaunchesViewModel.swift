//
//  LaunchesViewModel.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 31.05.2022.
//

import Foundation
import RxCocoa
import RxSwift

protocol LaunchesViewModelProtocol {
    var dataSourse: Driver<[LaunchViewData]> { get }
    var rocketName: String { get }
}

final class LaunchesViewModel: LaunchesViewModelProtocol {

    private let networkManager: NetworkManagerProtocol

    let dataSourse: Driver<[LaunchViewData]>
    let rocketName: String

    init(rocketName: String, rocketId: String, networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        self.rocketName = rocketName

        dataSourse = networkManager.getLaunches()
            .map { launches -> [LaunchViewData] in
                launches.filter { $0.rocket == rocketId }
                    .map { LaunchViewData(launch: $0) }
            }
            .asDriver(onErrorDriveWith: .never())
    }

}

//
//  LaunchesViewModel.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 31.05.2022.
//

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

        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM, yyyy"
            return dateFormatter
        }()

        dataSourse = networkManager.getLaunches()
            .map { launches -> [LaunchViewData] in
                launches.filter { $0.rocket == rocketId }
                    .map { LaunchViewData(
                        name: $0.name,
                        date: dateFormatter.string(from: $0.staticFireDateUnix ?? Date(timeIntervalSince1970: 0)),
                        result: $0.success ?? false
                    )
                    }
            }
            .asDriver(onErrorDriveWith: .never())
    }
}

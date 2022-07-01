//
//  RocketViewModel.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 27.06.2022.
//

import Moya
import RxCocoa
import RxSwift

protocol RocketViewModelProtocol {
    var name: String { get }
    var imageDataSource: Driver<Image> { get }
    var dataSource: [Section] { get }
    func setData()
    func tapOnSettings()
    func tapOnLaunches()
}

final class RocketViewModel: RocketViewModelProtocol {

    private let rocket: RocketViewData
    let imageDataSource: Driver<Image>
    let name: String
    private let networkManager: NetworkManagerProtocol
    private let router: RouterProtocol

    // let dataSource = BehaviorRelay<[Section]>(value: [])
    var dataSource = [Section]()

    private let firstStage: PublishSubject<[RocketCellModel]> = PublishSubject()

    init(rocket: Rocket, networkManager: NetworkManagerProtocol, router: RouterProtocol) {
        self.rocket = RocketViewData(rocket: rocket)
        self.networkManager = networkManager
        self.router = router
        name = rocket.name
        imageDataSource = networkManager.getImage(urlString: rocket.flickrImages.randomElement() ?? "")
            .asDriver(onErrorDriveWith: .never())

    }

    func setData() {
        dataSource += [
            Section(
                type: .parameters,
                cellModels:
                    [
                        RocketCellModel(
                            title: "Высота, ft",
                            value: rocket.height.feet,
                            measuringSystem: "ft"
                        ),
                        RocketCellModel(
                            title: "Диаметр, ft",
                            value: rocket.diameter.feet,
                            measuringSystem: "ft"
                        ),
                        RocketCellModel(
                            title: "Масса, lb",
                            value: rocket.mass.pound,
                            measuringSystem: "lb"
                        ),
                        RocketCellModel(
                            title: "Нагрузка, lb",
                            value: rocket.payloadWeights.pound,
                            measuringSystem: "lb"
                        )
                    ]
            ),
            Section(
                type: .information,
                cellModels:
                    [
                        RocketCellModel(
                            title: "Первый запуск",
                            value: rocket.firstFlight,
                            measuringSystem: ""
                        ),
                        RocketCellModel(
                            title: "Страна",
                            value: rocket.country,
                            measuringSystem: ""
                        ),
                        RocketCellModel(
                            title: "Стоимость запуска",
                            value: rocket.costPerLaunch,
                            measuringSystem: "$"
                        )
                    ]
            ),
            Section(
                type: .firstStage,
                cellModels:
                    [
                        RocketCellModel(
                            title: "Количество двигателей",
                            value: "\(rocket.firstStage.engines)",
                            measuringSystem: ""
                        ),
                        RocketCellModel(
                            title: "Количество топлива",
                            value: "\(rocket.firstStage.fuelAmountTons)",
                            measuringSystem: "ton"
                        ),
                        RocketCellModel(
                            title: "Время сгорания",
                            value: "\(rocket.firstStage.burnTimeSEC ?? 0)",
                            measuringSystem: "sec"
                        )
                    ]
            ),
            Section(
                type: .secondStage,
                cellModels:
                    [
                        RocketCellModel(
                            title: "Количество двигателей",
                            value: "\(rocket.secondStage.engines)",
                            measuringSystem: ""
                        ),
                        RocketCellModel(
                            title: "Количество топлива",
                            value: "\(rocket.secondStage.fuelAmountTons)",
                            measuringSystem: "ton"
                        ),
                        RocketCellModel(
                            title: "Время сгорания",
                            value: "\(rocket.secondStage.burnTimeSEC ?? 0)",
                            measuringSystem: "sec"
                        )
                    ]
            )
        ]
    }

    func tapOnSettings() {
        router.showSettings()
    }

    func tapOnLaunches() {
        router.showLaunches(rocketName: rocket.name, rocketId: rocket.id)
    }
}

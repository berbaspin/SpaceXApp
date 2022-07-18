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
    private let networkManager: NetworkManagerProtocol
    private let router: RouterProtocol
    private var settings: [Setting]
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM, yyyy"
        return dateFormatter
    }()

    let imageDataSource: Driver<Image>
    let name: String

    var isSettingsChanged = false
    var dataSource = [Section]()

    init(rocket: RocketViewData, settings: [Setting], networkManager: NetworkManagerProtocol, router: RouterProtocol) {
        self.rocket = rocket
        self.settings = settings
        self.networkManager = networkManager
        self.router = router
        name = rocket.name
        imageDataSource = networkManager.getImage(urlString: rocket.flickrImages.randomElement() ?? "")
            .asDriver(onErrorDriveWith: .never())

    }

    func setData() {
        guard settings.count == 4 else {
            return
        }
        dataSource = [
            Section(
                type: .parameters,
                cellModels:
                    [
                        RocketCellModel(
                            title: "Высота, \(measureType(setting: settings[0]))",
                            value: settings[0].isUS ? rocket.height.feet : rocket.height.meters,
                            measuringSystem: "\(measureType(setting: settings[0]))"
                        ),
                        RocketCellModel(
                            title: "Диаметр, \(measureType(setting: settings[1]))",
                            value: settings[1].isUS ? rocket.diameter.feet: rocket.diameter.meters,
                            measuringSystem: "\(measureType(setting: settings[1]))"
                        ),
                        RocketCellModel(
                            title: "Масса, \(measureType(setting: settings[2]))",
                            value: settings[2].isUS ? rocket.mass.pound : rocket.mass.kilogram,
                            measuringSystem: "\(measureType(setting: settings[2]))"
                        ),
                        RocketCellModel(
                            title: "Нагрузка, \(measureType(setting: settings[3]))",
                            value: settings[3].isUS ? rocket.payloadWeights.pound : rocket.payloadWeights.kilogram,
                            measuringSystem: "\(measureType(setting: settings[3]))"
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

    private func measureType(setting: Setting) -> String {
        setting.isUS ? setting.units[1].rawValue : setting.units[0].rawValue
    }

    func tapOnSettings() {
        router.showSettings(settings: settings)
    }

    func tapOnLaunches() {
        router.showLaunches(rocketName: rocket.name, rocketId: rocket.id)
    }
}

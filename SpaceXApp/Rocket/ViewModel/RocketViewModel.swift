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
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM, yyyy"
        return dateFormatter
    }()

    let imageDataSource: Driver<Image>
    let name: String

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
        dataSource = [
            createParametersSection(), createInformationSection(), createFirstStageSection(), createSecondStageSection()
        ]
    }

    func tapOnSettings() {
        router.showSettings(settings: settings)
    }

    func tapOnLaunches() {
        router.showLaunches(rocketName: rocket.name, rocketId: rocket.id)
    }
}

// MARK: Sections creation

private extension RocketViewModel {
    func createParametersSection() -> Section {
        Section(
            type: .parameters,
            cellModels:
                [
                    RocketCellModel(
                        title: "\(settings[0].type.name), \(measureType(setting: settings[0]))",
                        value: settings[0].isUS ? rocket.height.feet : rocket.height.meters,
                        measuringSystem: "\(measureType(setting: settings[0]))"
                    ),
                    RocketCellModel(
                        title: "\(settings[1].type.name), \(measureType(setting: settings[1]))",
                        value: settings[1].isUS ? rocket.diameter.feet: rocket.diameter.meters,
                        measuringSystem: "\(measureType(setting: settings[1]))"
                    ),
                    RocketCellModel(
                        title: "\(settings[2].type.name), \(measureType(setting: settings[2]))",
                        value: settings[2].isUS ? rocket.mass.pound : rocket.mass.kilogram,
                        measuringSystem: "\(measureType(setting: settings[2]))"
                    ),
                    RocketCellModel(
                        title: "\(settings[3].type.name), \(measureType(setting: settings[3]))",
                        value: settings[3].isUS ? rocket.payloadWeights.pound : rocket.payloadWeights.kilogram,
                        measuringSystem: "\(measureType(setting: settings[3]))"
                    )
                ]
        )
    }

    func createInformationSection() -> Section {
        Section(
            type: .information,
            cellModels:
                [
                    RocketCellModel(
                        title: "First launch".localized(),
                        value: rocket.firstFlight,
                        measuringSystem: ""
                    ),
                    RocketCellModel(
                        title: "Country".localized(),
                        value: rocket.country,
                        measuringSystem: ""
                    ),
                    RocketCellModel(
                        title: "Launch cost".localized(),
                        value: rocket.costPerLaunch,
                        measuringSystem: "$"
                    )
                ]
        )
    }

    func createFirstStageSection() -> Section {
        Section(
            type: .firstStage,
            cellModels:
                [
                    RocketCellModel(
                        title: "Number of engines".localized(),
                        value: "\(rocket.firstStage.engines)",
                        measuringSystem: ""
                    ),
                    RocketCellModel(
                        title: "Fuel amount".localized(),
                        value: "\(rocket.firstStage.fuelAmountTons)",
                        measuringSystem: "ton"
                    ),
                    RocketCellModel(
                        title: "Burn time".localized(),
                        value: "\(rocket.firstStage.burnTimeSEC ?? 0)",
                        measuringSystem: "sec"
                    )
                ]
        )
    }

    func createSecondStageSection() -> Section {
        Section(
            type: .secondStage,
            cellModels:
                [
                    RocketCellModel(
                        title: "Number of engines".localized(),
                        value: "\(rocket.secondStage.engines)",
                        measuringSystem: ""
                    ),
                    RocketCellModel(
                        title: "Fuel amount".localized(),
                        value: "\(rocket.secondStage.fuelAmountTons)",
                        measuringSystem: "ton"
                    ),
                    RocketCellModel(
                        title: "Burn time".localized(),
                        value: "\(rocket.secondStage.burnTimeSEC ?? 0)",
                        measuringSystem: "sec"
                    )
                ]
        )
    }

    func measureType(setting: Setting) -> String {
        setting.isUS ? setting.units[1].rawValue : setting.units[0].rawValue
    }
}

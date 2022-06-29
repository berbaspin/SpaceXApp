//
//  RocketViewModel.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 27.06.2022.
//

import RxCocoa
import RxSwift

protocol RocketViewModelProtocol {
    var rocket: Rocket { get }
    func tapOnSettings()
    func tapOnLaunches()
}

final class RocketViewModel: RocketViewModelProtocol {

    let rocket: Rocket
    private let router: RouterProtocol

    let firstStage: PublishSubject<[RocketCellModel]> = PublishSubject()

    init(rocket: Rocket, router: RouterProtocol) {
        self.rocket = rocket
        self.router = router
    }

    func setData() {
        firstStage.onNext(
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
            ])
    }

    func getFirstStage() -> [RocketCellModel] {
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
    }

    func getSecondStage() -> [RocketCellModel] {
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
    }

    func tapOnSettings() {
        router.showSettings()
    }

    func tapOnLaunches() {
        router.showLaunches(rocketName: rocket.name, rocketId: rocket.id)
    }
}

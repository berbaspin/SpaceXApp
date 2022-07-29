//
//  MainViewModel.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 07.06.2022.
//
import Foundation
import RxCocoa
import RxSwift

protocol MainViewModelProtocol {
    var dataSource: Driver<[RocketViewModel]> { get }
    func getData()
}

final class MainViewModel: MainViewModelProtocol {
    private let networkManager: NetworkManagerProtocol
    private let router: RouterProtocol
    private var rockets: PublishSubject<[RocketViewModel]> = PublishSubject()
    private var isSettingsChanged = true
    private let disposeBag = DisposeBag()

    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM, yyyy"
        return dateFormatter
    }()

    private lazy var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }()

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
    var dataSource: Driver<[RocketViewModel]> {
        rockets.asDriver(onErrorDriveWith: .never())
    }

    init(networkManager: NetworkManagerProtocol, router: RouterProtocol) {
        self.networkManager = networkManager
        self.router = router
    }

    func getData() {
        // swiftlint:disable:next trailing_closure
        networkManager.getRockets()
            .map { rockets -> [RocketViewModel] in
                rockets.map { [unowned self] rocket in
                    let rocketViewData = self.createRocketViewData(rocket: rocket)
                    return RocketViewModel(
                        rocket: rocketViewData,
                        settings: self.settings,
                        networkManager: self.networkManager,
                        router: self.router
                    )
                }
            }
            .asObservable()
            .subscribe(onNext: { [unowned self] rocketViewModels in
                self.rockets.onNext(rocketViewModels)
            })
            .disposed(by: disposeBag)
    }

    private func createRocketViewData(rocket: Rocket) -> RocketViewData {
        let payloadWeight = rocket.payloadWeights.filter { $0.id == "leo" }.first
        let cost = String(format: "%g", Double(rocket.costPerLaunch) / 1_000_000)

        return RocketViewData(
            id: rocket.id,
            name: rocket.name,
            country: rocket.country,
            costPerLaunch: "$\(cost) " + "M".localized(),
            firstFlight: dateFormatter.string(from: rocket.firstFlight),
            height: RocketViewData.Diameter(
                meters: "\(rocket.height.meters ?? 0)",
                feet: "\(rocket.height.feet ?? 0)"
            ),
            diameter: RocketViewData.Diameter(
                meters: "\(rocket.diameter.meters ?? 0)",
                feet: "\(rocket.diameter.feet ?? 0)"
            ),
            mass: RocketViewData.Mass(
                kilogram: numberFormatter.string(from: rocket.mass.kilogram as NSNumber) ?? "No Value",
                pound: numberFormatter.string(from: rocket.mass.pound as NSNumber) ?? "No Value"
            ),
            payloadWeights: RocketViewData.PayloadWeight(
                id: payloadWeight?.id ?? "No Value",
                name: payloadWeight?.name ?? "No Value",
                kilogram: numberFormatter.string(from: (payloadWeight?.kilogram ?? 0) as NSNumber) ?? "No Value",
                pound: numberFormatter.string(from: (payloadWeight?.pound ?? 0) as NSNumber) ?? "No Value"
            ),
            firstStage: RocketViewData.FirstStage(
                engines: rocket.firstStage.engines,
                fuelAmountTons: rocket.firstStage.fuelAmountTons,
                burnTimeSEC: rocket.firstStage.burnTimeSEC
            ),
            secondStage: RocketViewData.SecondStage(
                engines: rocket.secondStage.engines,
                fuelAmountTons: rocket.secondStage.fuelAmountTons,
                burnTimeSEC: rocket.secondStage.burnTimeSEC
            ),
            flickrImages: rocket.flickrImages
        )
    }
}

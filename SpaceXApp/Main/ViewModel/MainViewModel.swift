//
//  MainViewModel.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 07.06.2022.
//

import RxCocoa
import RxSwift

protocol MainViewModelProtocol {
    var dataSourse: Driver<[RocketViewModel]> { get }
    var isSettingsChanged: Bool { get }
    func getData()
    func updateSettings(settings: [Setting])
}

final class MainViewModel: MainViewModelProtocol {
    private let networkManager: NetworkManagerProtocol
    private let router: RouterProtocol
    private let disposeBag = DisposeBag()

    private var rockets: PublishSubject<[RocketViewModel]> = PublishSubject()
    var dataSourse: Driver<[RocketViewModel]> {
        rockets.asDriver(onErrorDriveWith: .never())
    }
    var isSettingsChanged = true
    private var settings: [Setting] {
        get {
            guard let savedData = UserDefaults.standard.object(forKey: "availableSettings") as? Data,
                let decodedSettings = try? PropertyListDecoder().decode([Setting].self, from: savedData) else {
                return Setting.availableSettings()
            }
            return decodedSettings
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: "availableSettings")
        }
    }

    init(networkManager: NetworkManagerProtocol, router: RouterProtocol) {
        self.networkManager = networkManager
        self.router = router
    }

    func getData() {
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM, yyyy"
            return dateFormatter
        }()
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "en_US")

        networkManager.getRockets()
            .map { rockets -> [RocketViewModel] in
                rockets.map { [unowned self] rocket in
                    let payloadWeight = rocket.payloadWeights.filter { $0.id == "leo" }.first

                    let rocketViewData = RocketViewData(
                        id: rocket.id,
                        name: rocket.name,
                        country: rocket.country,
                        costPerLaunch: currencyFormatter.string(
                            from: rocket.costPerLaunch as NSNumber
                        ) ?? "Unknown value",
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
                            kilogram: "\(rocket.mass.kilogram)",
                            pound: "\(rocket.mass.pound)"
                        ),
                        payloadWeights: RocketViewData.PayloadWeight(
                            id: payloadWeight?.id ?? "No Value",
                            name: payloadWeight?.name ?? "No Value",
                            kilogram: "\(payloadWeight?.kilogram ?? 0)",
                            pound: "\(payloadWeight?.pound ?? 0)"
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

    func updateSettings(settings: [Setting]) {
        isSettingsChanged = self.settings != settings
        guard isSettingsChanged else {
            return
        }
        self.settings = settings
        getData()
    }
}

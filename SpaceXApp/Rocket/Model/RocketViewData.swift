//
//  RocketViewData.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 01.07.2022.
//

import Foundation

struct RocketViewData {
    let id: String
    let name: String
    let country: String
    let costPerLaunch: String
    let firstFlight: String
    let height: Diameter
    let diameter: Diameter
    let mass: Mass
    let payloadWeights: PayloadWeight
    let firstStage: FirstStage
    let secondStage: SecondStage
    let flickrImages: [String]

    init(rocket: Rocket) {
        id = rocket.id
        name = rocket.name
        country = rocket.country

        // TODO: add abbreviation
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "en_US")
        costPerLaunch = currencyFormatter.string(from: rocket.costPerLaunch as NSNumber) ?? "Unknown value"

        // FIXME: Force unwrapping
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let flightDate = dateFormatter.date(from: rocket.firstFlight)
        dateFormatter.dateFormat = "dd MMMM, yyyy"
        firstFlight = dateFormatter.string(from: flightDate!)

        height = Diameter(rocket.height)
        diameter = Diameter(rocket.diameter)
        mass = Mass(rocket.mass)
        // FIXME: Force unwrapping
        payloadWeights = PayloadWeight(rocket.payloadWeights.filter {$0.id == "leo"}.first!)
        firstStage = FirstStage(rocket.firstStage)
        secondStage = SecondStage(rocket.secondStage)
        flickrImages = rocket.flickrImages
    }
}

extension RocketViewData {
    struct FirstStage {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSEC: Int?

        init(_ firstStage: Rocket.FirstStage) {
            engines = firstStage.engines
            fuelAmountTons = firstStage.fuelAmountTons
            burnTimeSEC = firstStage.burnTimeSEC
        }
    }

    struct SecondStage {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSEC: Int?

        init(_ secondStage: Rocket.SecondStage) {
            engines = secondStage.engines
            fuelAmountTons = secondStage.fuelAmountTons
            burnTimeSEC = secondStage.burnTimeSEC
        }
    }

    struct Diameter {
        let meters, feet: String

        init(_ diameter: Rocket.Diameter) {
            meters = String(describing: diameter.meters ?? 0)
            feet = String(describing: diameter.feet ?? 0)
        }
    }

    struct Mass {
        let kilogram, pound: String

        init(_ mass: Rocket.Mass) {
            kilogram = String(describing: mass.kilogram)
            pound = String(describing: mass.pound)
        }
    }

    struct PayloadWeight {
        let id, name, kilogram, pound: String

        init(_ payload: Rocket.PayloadWeight) {
            id = payload.id
            name = payload.name
            kilogram = String(describing: payload.kilogram)
            pound = String(describing: payload.pound)
        }
    }
}

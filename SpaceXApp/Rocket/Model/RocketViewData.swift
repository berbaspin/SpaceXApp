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
}

extension RocketViewData {
    struct FirstStage {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSEC: Int?
    }

    struct SecondStage {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSEC: Int?
    }

    struct Diameter {
        let meters: String
        let feet: String
    }

    struct Mass {
        let kilogram: String
        let pound: String
    }

    struct PayloadWeight {
        let id: String
        let name: String
        let kilogram: String
        let pound: String
    }
}

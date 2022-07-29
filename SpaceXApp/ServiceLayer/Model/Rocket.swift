//
//  Rocket.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 26.05.2022.
//

import Foundation

struct Rocket: Decodable {
    let height, diameter: Diameter
    let mass: Mass
    let firstStage: FirstStage
    let secondStage: SecondStage
    let payloadWeights: [PayloadWeight]
    let flickrImages: [String]
    let name: String
    let type: String
    let costPerLaunch: Int
    let firstFlight: Date
    let country: String
    let id: String
}

extension Rocket {
    // MARK: - Diameter
    struct Diameter: Decodable {
        let meters: Double?
        let feet: Double?
    }

    // MARK: - Mass
    struct Mass: Decodable {
        let kilogram: Int
        let pound: Int

        enum CodingKeys: String, CodingKey {
            case kilogram = "kg"
            case pound = "lb"
        }
    }

    // MARK: - PayloadWeight
    struct PayloadWeight: Decodable {
        let id: String
        let name: String
        let kilogram: Int
        let pound: Int

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case kilogram = "kg"
            case pound = "lb"
        }
    }

    // MARK: - FirstStage
    struct FirstStage: Decodable {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSEC: Int?
    }

    // MARK: - SecondStage
    struct SecondStage: Decodable {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSEC: Int?
    }

    // MARK: - CompositeFairing
    struct CompositeFairing: Decodable {
        let height: Diameter
        let diameter: Diameter
    }
}

//
//  Rocket.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 26.05.2022.
//

import Foundation

// MARK: - Rocket
struct Rocket: Codable {
    let height, diameter: Diameter
    let mass: Mass
    let firstStage: FirstStage
    let secondStage: SecondStage
    let engines: Engines
    let landingLegs: LandingLegs
    let payloadWeights: [PayloadWeight]
    let flickrImages: [String]
    let name, type: String
    let active: Bool
    let stages, boosters, costPerLaunch, successRatePct: Int
    let firstFlight, country, company: String
    // let wikipedia: String
    let description, id: String
}

// MARK: - Diameter
struct Diameter: Codable {
    let meters, feet: Double?
}

// MARK: - Engines
struct Engines: Codable {
    let isp: ISP
    let number: Int
    let type, version: String
    let layout: String?
    let engineLossMax: Int?
    let propellant1, propellant2: String
    let thrustToWeight: Double
}

// MARK: - ISP
struct ISP: Codable {
    let seaLevel, vacuum: Int
}

// MARK: - FirstStage
struct FirstStage: Codable {
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSEC: Int?
}

// MARK: - LandingLegs
struct LandingLegs: Codable {
    let number: Int
    let material: String?
}

// MARK: - Mass
struct Mass: Codable {
    let kilogram, pound: Int

    enum CodingKeys: String, CodingKey {
        case kilogram = "kg"
        case pound = "lb"
    }
}

// MARK: - PayloadWeight
struct PayloadWeight: Codable {
    let id, name: String
    let kilogram, pound: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case kilogram = "kg"
        case pound = "lb"
    }

}

// MARK: - SecondStage
struct SecondStage: Codable {
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSEC: Int?
}

// MARK: - CompositeFairing
struct CompositeFairing: Codable {
    let height, diameter: Diameter
}

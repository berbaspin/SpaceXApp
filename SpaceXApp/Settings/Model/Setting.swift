//
//  Setting.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 31.05.2022.
//

import Foundation

struct Setting {
    let type: SettingsType
    let units: [Units]
    let isUS: Bool
}

extension Setting {
    enum SettingsType: String {
        case height = "Height"
        case diameter = "Diameter"
        case mass = "Mass"
        case payloadWeights = "Payload weights"
    }

    enum Units: String {
        case meters = "m"
        case feet = "ft"
        case kilogram = "kg"
        case pound = "lb"
    }

    static func availableSettings() -> [Setting] {[
        Setting(type: .height, units: [.meters, .feet], isUS: true),
        Setting(type: .diameter, units: [.meters, .feet], isUS: true),
        Setting(type: .mass, units: [.kilogram, .pound], isUS: true),
        Setting(type: .payloadWeights, units: [.kilogram, .pound], isUS: true)
    ]}
}

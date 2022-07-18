//
//  Setting.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 31.05.2022.
//

import Foundation

struct Setting: Codable, Equatable {
    let type: SettingsType
    let units: [Units]
    var isUS: Bool
}

extension Setting {
    enum SettingsType: Codable {
        case height
        case diameter
        case mass
        case payloadWeights

        var name: String {
            switch self {
            case .height:
                return "Height".localized()
            case .diameter:
                return "Diameter".localized()
            case .mass:
                return "Mass".localized()
            case .payloadWeights:
                return "Payload".localized()
            }
        }
    }

    enum Units: String, Codable {
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

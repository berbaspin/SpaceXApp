//
//  Setting.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 31.05.2022.
//

import Foundation

struct Setting {

    let type: String
    let units: [String]

    static func availableSettings() -> [Setting] {
        [
            Setting(type: "Высота", units: ["m", "ft"]),
            Setting(type: "Диаметр", units: ["m", "ft"]),
            Setting(type: "Масса", units: ["kg", "lb"]),
            Setting(type: "Полезная нагрузка", units: ["kg", "lb"])
        ]
    }
}

//
//  Launch.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 31.05.2022.
//

import Foundation

struct LaunchViewData {
    let name: String
    let date: String
    let result: Bool

    init(name: String, date: String, result: Bool) {
        self.name = name
        self.date = date
        self.result = result
    }
}

//
//  Launch.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 31.05.2022.
//

import Foundation

struct Launch {
    let name: String
    let date: String
    let result: Bool

    static func getLaunches() -> [Launch] {
        [
            Launch(name: "FalconSat", date: "2 февраля, 2022", result: true),
            Launch(name: "Heavy holidays", date: "2 февраля, 2022", result: true),
            Launch(name: "CRS-24 Mission", date: "2 февраля, 2022", result: false)
        ]
    }
}

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

    init(launch: Launch) {
        name = launch.name
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM, yyyy"
        date = dateFormatter.string(
            from: Date(timeIntervalSince1970: Double(launch.staticFireDateUnix ?? 15_627_600))
        )
        result = launch.success ?? false
    }
}

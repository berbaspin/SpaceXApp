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

    init(launch: LaunchWrapped) {
        self.name = launch.name
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM, yyyy"
        self.date = dateFormatter.string(
            from: Date(timeIntervalSince1970: Double(launch.staticFireDateUnix ?? 415_637_900))
        )
        self.result = launch.success ?? false
    }
}

//
//  LaunchWrapped.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 21.06.2022.
//

import Foundation

struct LaunchWrapped: Codable {
    let name: String
    let staticFireDateUnix: Int?
    let success: Bool?
    let rocket: String
}

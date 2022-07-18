//
//  LaunchWrapped.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 21.06.2022.
//

import Foundation

// MARK: - Launch
struct Launch: Decodable {
    let name: String
    let staticFireDateUnix: Date?
    // swiftlint:disable:next discouraged_optional_boolean
    let success: Bool?
    let rocket: String
}

//
//  NetworkManager.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 14.06.2022.
//

import RxSwift
import Moya

protocol NetworkManagerProtocol {
    func getRockets() -> Single<[Rocket]>
    func getLaunches() -> Single<[LaunchWrapped]>
}

final class NetworkManager: NetworkManagerProtocol {

    private let provider = MoyaProvider<NetworkService>()
    private let decoder = JSONDecoder()

    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func getRockets() -> Single<[Rocket]> {
        provider
            .rx
            .request(.getRockets)
            .filterSuccessfulStatusCodes()
            .map([Rocket].self, using: decoder)
    }

    func getLaunches() -> Single<[LaunchWrapped]> {
        provider
            .rx
            .request(.getLaunches)
            .filterSuccessfulStatusCodes()
            .map([LaunchWrapped].self, using: decoder)
    }
}

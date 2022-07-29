//
//  NetworkManager.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 14.06.2022.
//

import Moya
import RxSwift

protocol NetworkManagerProtocol {
    func getRockets() -> Single<[Rocket]>
    func getLaunches() -> Single<[Launch]>
    func getImage(urlString: String) -> Single<Image>
}

final class NetworkManager: NetworkManagerProtocol {

    private let provider: MoyaProvider<NetworkService>
    private let decoder: JSONDecoder

    init(decoder: JSONDecoder, provider: MoyaProvider<NetworkService> = .init()) {
        self.decoder = decoder
        self.provider = provider
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func getRockets() -> Single<[Rocket]> {
        provider.rx
            .request(.getRockets)
            .filterSuccessfulStatusCodes()
            .map([Rocket].self, using: decoder)
    }

    func getLaunches() -> Single<[Launch]> {
        provider.rx
            .request(.getLaunches)
            .filterSuccessfulStatusCodes()
            .map([Launch].self, using: decoder)
    }

    func getImage(urlString: String) -> Single<Image> {
        provider.rx
            .request(.getImage(urlString: urlString))
            .mapImage()
    }
}

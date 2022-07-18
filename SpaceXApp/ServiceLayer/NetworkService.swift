//
//  NetworkService.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 27.05.2022.
//

import Moya

enum NetworkService {
    case getRockets
    case getLaunches
    case getImage(urlString: String)
}

extension NetworkService: TargetType {

    // swiftlint:disable all
    var baseURL: URL {
        switch self {
        case .getRockets:
            return URL(string: "https://api.spacexdata.com")!
        case .getLaunches:
            return URL(string: "https://api.spacexdata.com")!
        case .getImage(urlString: let urlString):
            return URL(string: urlString)!
        }
    }

    var path: String {
        switch self {
        case .getRockets:
            return "/v4/rockets"
        case .getLaunches:
            return "/v4/launches"
        case .getImage:
            return ""
        }
    }

    var method: Method {
        .get
    }

    var sampleData: Data {
        Data()
    }

    var task: Task {
        .requestPlain
    }

    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }

}

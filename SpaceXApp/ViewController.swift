//
//  ViewController.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 26.05.2022.
//

import RxSwift
import UIKit
import Moya

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let provider = MoyaProvider<NetworkManager>()
        provider.request(.getRockets) { result in
            switch result {
            case .success(let response):
                let rocketsResponse = try? response.mapJSON()
                print(rocketsResponse)
            case .failure(let error):
                print(error.errorDescription ?? "Unknown error")
            }
        }
    }

}

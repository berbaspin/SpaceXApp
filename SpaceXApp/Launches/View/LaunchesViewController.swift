//
//  LaunchesViewController.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 31.05.2022.
//

import UIKit

final class LaunchesViewController: UITableViewController {

    private let launches = Launch.getLaunches()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(
            LaunchesTableViewCell.self,
            forCellReuseIdentifier: String(describing: LaunchesTableViewCell.self)
        )
        title = "Falcon Heavy"
        view.backgroundColor = .black
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        launches.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: LaunchesTableViewCell.self),
            for: indexPath
        ) as? LaunchesTableViewCell
        let launch = launches[indexPath.row]
        let image = launch.result ? UIImage(named: "success") : UIImage(named: "failure")

        cell?.setup(
            name: launch.name,
            date: launch.date,
            image: image
        )

        return cell ?? UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }

}

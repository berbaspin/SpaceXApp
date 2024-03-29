//
//  LaunchesViewController.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 31.05.2022.
//

import RxCocoa
import RxSwift
import UIKit

final class LaunchesViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        return tableView
    }()
    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: LaunchesViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.rocketName
        view.backgroundColor = .black
        setupBindings()
        setHierachy()
        setLayout()
        setupTableView()
    }

    private func setupBindings() {

        viewModel.dataSourse
            .drive(
                tableView.rx
                    .items(
                        cellIdentifier: String(describing: LaunchesTableViewCell.self),
                        cellType: LaunchesTableViewCell.self
                    )
            ) { _, model, cell in
                cell.setup(model: model)
            }
            .disposed(by: disposeBag)
    }

    private func setupTableView() {
        tableView.registerCell(type: LaunchesTableViewCell.self)
        tableView.rowHeight = 130
    }

}

// MARK: - Setup Layout

private extension LaunchesViewController {
    func setHierachy() {
        view.addSubview(tableView)
    }

    func setLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

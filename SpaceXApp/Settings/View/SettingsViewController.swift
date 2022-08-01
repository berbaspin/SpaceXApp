//
//  SettingsViewController.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 30.05.2022.
//

import RxCocoa
import RxSwift
import UIKit

final class SettingsViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let disposeBag = DisposeBag()

    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: SettingsViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setHierarchy()
        setLayout()
        bind()
        setupNavigationBar()
        setupTableView()
        view.backgroundColor = .black
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.closeViewController()
    }

    private func bind() {

        viewModel.dataSource
            .drive(
                tableView.rx
                    .items(
                        cellIdentifier: String(describing: SettingsTableViewCell.self),
                        cellType: SettingsTableViewCell.self
                    )
            ) { _, model, cell in
                cell.setup(model: model) { [weak self] in
                    guard let self = self else {
                        return
                    }
                    self.viewModel.updateSettings(setting: model, isUS: $0)
                }
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - Setup Methods

private extension SettingsViewController {
    func setupNavigationBar() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.title = "Settings"
        let doneItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(closeViewController)
        )
        navigationController?.navigationBar.topItem?.rightBarButtonItem = doneItem
    }

    func setupTableView() {
        tableView.registerCell(type: SettingsTableViewCell.self)
        tableView.rowHeight = 70
        tableView.backgroundColor = .black
    }

    @objc
    func closeViewController() {
        dismiss(animated: true)
    }
}

// MARK: - Setup Layout

private extension SettingsViewController {
    func setHierarchy() {
        view.addSubview(tableView)
    }

    func setLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

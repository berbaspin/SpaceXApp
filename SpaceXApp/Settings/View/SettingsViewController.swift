//
//  SettingsViewController.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 30.05.2022.
//

import UIKit

final class SettingsViewController: UIViewController {

    private let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.barStyle = UIBarStyle.black
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .white
        let titleItem = UINavigationItem(title: "Настройки")
        let doneItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: nil,
            action: #selector(closeViewController)
        )
        titleItem.rightBarButtonItem = doneItem
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.setItems([titleItem], animated: false)
        return navigationBar
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let settings = Setting.availableSettings()

    override func viewDidLoad() {
        super.viewDidLoad()
        overlayFirstLayer()
        configureTableView()
        view.backgroundColor = .black
    }
}

// MARK: - Setup Methods

private extension SettingsViewController {
    private func configureTableView() {
        tableView.register(
            SettingsTableViewCell.self,
            forCellReuseIdentifier: String(describing: SettingsTableViewCell.self)
        )
        tableView.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
    }

    @objc
    private func closeViewController() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true)
    }
}

// MARK: - Layout Constraints

private extension SettingsViewController {
    private func overlayFirstLayer() {
        view.addSubview(navigationBar)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 44),

            tableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 50),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: SettingsTableViewCell.self),
            for: indexPath
        ) as? SettingsTableViewCell

        cell?.setup(text: settings[indexPath.row].type, items: settings[indexPath.row].units)

        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}

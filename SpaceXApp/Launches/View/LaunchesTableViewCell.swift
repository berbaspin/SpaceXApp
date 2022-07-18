//
//  LaunchesTableViewCell.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 31.05.2022.
//

import UIKit

final class LaunchesTableViewCell: UITableViewCell {

    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "DarkGray")
        view.layer.cornerRadius = 20
        return view
    }()

    private let labelsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "Gray")
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let statusImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        selectionStyle = .none
        setHierarchy()
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(name: String, date: String, image: UIImage?) {
        titleLabel.text = name
        dateLabel.text = date
        statusImage.image = image
    }
}

// MARK: - Setup Layout

private extension LaunchesTableViewCell {

    func setHierarchy() {
        contentView.addSubview(mainView)

        mainView.addSubview(labelsStack)
        mainView.addSubview(statusImage)

        labelsStack.addArrangedSubview(titleLabel)
        labelsStack.addArrangedSubview(dateLabel)
    }

    func setLayout() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])

        NSLayoutConstraint.activate([
            labelsStack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 25),
            labelsStack.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),

            statusImage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -25),
            statusImage.leadingAnchor.constraint(equalTo: labelsStack.trailingAnchor, constant: 10),
            statusImage.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),

            statusImage.widthAnchor.constraint(equalToConstant: 40),
            statusImage.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

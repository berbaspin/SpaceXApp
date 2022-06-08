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
        view.backgroundColor = UIColor(red: 33 / 255, green: 33 / 255, blue: 33 / 255, alpha: 1)
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
        label.text = "FalconSat"
        label.textColor = .white
        label.font = .systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2 февраля, 2022"
        label.textColor = UIColor(
            red: 142 / 255,
            green: 142 / 255,
            blue: 143 / 255,
            alpha: 1
        )
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let statusImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "success")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgroundColor = .black
        selectionStyle = .none
        overlayFirstLayer()
        overlaySecondLayer()
        overlayThirdLayer()
    }

    func setup(name: String, date: String, image: UIImage?) {
        titleLabel.text = name
        dateLabel.text = date
        statusImage.image = image
    }
}

// MARK: - Layout Constraints

private extension LaunchesTableViewCell {
    func overlayThirdLayer() {
        labelsStack.addArrangedSubview(titleLabel)
        labelsStack.addArrangedSubview(dateLabel)
    }

    func overlaySecondLayer() {
        mainView.addSubview(labelsStack)
        mainView.addSubview(statusImage)

        NSLayoutConstraint.activate(
            [
                labelsStack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 25),
                labelsStack.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),

                statusImage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -25),
                statusImage.leadingAnchor.constraint(equalTo: labelsStack.trailingAnchor, constant: 10),
                statusImage.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),

                statusImage.widthAnchor.constraint(equalToConstant: 40),
                statusImage.heightAnchor.constraint(equalToConstant: 40)
            ]
        )
    }

    func overlayFirstLayer() {
        contentView.addSubview(mainView)

        NSLayoutConstraint.activate(
            [
                mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
                mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
            ]
        )
    }
}

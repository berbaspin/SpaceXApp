//
//  ParametersCell.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 04.06.2022.
//

import UIKit

protocol RocketsCollectionViewCellProtocol {
    func setup(with parameters: RocketCellModel)
}

final class ParametersCell: UICollectionViewCell, RocketsCollectionViewCellProtocol {

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let paramenterValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let paramenterNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "Gray")
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = UIColor(named: "DarkGray")
        layer.cornerRadius = 30
        setHierarchy()
        setLayout()
    }

    func setup(with parameters: RocketCellModel) {
        paramenterNameLabel.text = parameters.title
        paramenterValueLabel.text = parameters.value
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Layout

private extension ParametersCell {
    func setHierarchy() {
        contentView.addSubview(stackView)

        [paramenterValueLabel, paramenterNameLabel].forEach(stackView.addArrangedSubview)
    }

    func setLayout() {

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1 / 2),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
}

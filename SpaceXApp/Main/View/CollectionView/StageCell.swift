//
//  InformationCell.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 05.06.2022.
//

import UIKit

final class StageCell: UICollectionViewCell {

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(
            red: 202 / 255,
            green: 202 / 255,
            blue: 202 / 255,
            alpha: 1
        )
        return label
    }()

    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    private let measuringSystemLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = UIColor(
            red: 142 / 255,
            green: 142 / 255,
            blue: 143 / 255,
            alpha: 1
        )
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        overlayFirstLayer()
        overlaySecondLayer()
    }

    func configure(with parameters: Cell) {
        titleLabel.text = parameters.title
        valueLabel.text = parameters.value
        measuringSystemLabel.text = parameters.measuringSystem
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout Constraints

private extension StageCell {
    func overlaySecondLayer() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
        stackView.addArrangedSubview(measuringSystemLabel)

        NSLayoutConstraint.activate([
            valueLabel.widthAnchor.constraint(equalToConstant: 50),
            measuringSystemLabel.widthAnchor.constraint(equalToConstant: 30)
        ])
    }

    func overlayFirstLayer() {
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
                stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

//
//  ParametersCell.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 04.06.2022.
//

import UIKit

final class ParametersCell: UICollectionViewCell {

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
        label.textColor = UIColor(
            red: 142 / 255,
            green: 142 / 255,
            blue: 143 / 255,
            alpha: 1
        )
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = UIColor(
            red: 33 / 255,
            green: 33 / 255,
            blue: 33 / 255,
            alpha: 1
        )
        layer.cornerRadius = 30
        overlayFirstLayer()
        overlaySecondLayer()
    }

    func configure(with parameters: Cell) {
        paramenterNameLabel.text = parameters.title
        paramenterValueLabel.text = parameters.value
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout Constraints

private extension ParametersCell {
    private func overlaySecondLayer() {
        stackView.addArrangedSubview(paramenterValueLabel)
        stackView.addArrangedSubview(paramenterNameLabel)
    }

    private func overlayFirstLayer() {
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
                stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

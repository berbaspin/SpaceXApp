//
//  HeaderView.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 01.06.2022.
//

import UIKit

final class HeaderView: UICollectionReusableView {

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 26)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let settingsButton: UIButton = {
        let button = UIButton(type: .system)

        let image = UIImage(
            systemName: "gearshape",
            withConfiguration: UIImage.SymbolConfiguration(scale: .large)
        )?.withTintColor(
            UIColor(
                red: 202 / 255,
                green: 202 / 255,
                blue: 202 / 255,
                alpha: 1
            ),
            renderingMode: .alwaysOriginal
        )
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 25
        backgroundColor = .black
        overlayFirstLayer()
        overlaySecondLayer()
    }

    func configure(with title: String) {
        titleLabel.text = title
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout Constraints

private extension HeaderView {
    func overlaySecondLayer() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(settingsButton)

        NSLayoutConstraint.activate([
            settingsButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func overlayFirstLayer() {
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
}

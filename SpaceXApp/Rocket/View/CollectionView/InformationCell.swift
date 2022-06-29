//
//  InformationCell.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 05.06.2022.
//

import UIKit

final class InformationCell: UICollectionViewCell {

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(named: "LightGray")
        return label
    }()

    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setLayout()
    }

    func setup(with cellModel: RocketCellModel) {
        titleLabel.text = cellModel.title
        valueLabel.text = cellModel.value
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Layout

private extension InformationCell {
    func setHierarchy() {
        contentView.addSubview(stackView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
    }

    func setLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

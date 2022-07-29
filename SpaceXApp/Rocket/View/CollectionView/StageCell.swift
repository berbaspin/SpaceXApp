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
        label.textColor = UIColor(named: "LightGray")
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
        label.textColor = UIColor(named: "Gray")
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with cellModel: RocketCellModel) {
        titleLabel.text = cellModel.title
        valueLabel.text = cellModel.value
        measuringSystemLabel.text = cellModel.measuringSystem
    }
}

// MARK: - Setup Layout

private extension StageCell {
    func setHierarchy() {
        contentView.addSubview(stackView)

        [titleLabel, valueLabel, measuringSystemLabel].forEach(stackView.addArrangedSubview)
    }

    func setLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            valueLabel.widthAnchor.constraint(equalToConstant: 60),
            measuringSystemLabel.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}

//
//  SettingsTableViewCell.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 30.05.2022.
//

import UIKit

final class SettingsTableViewCell: UITableViewCell {
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()

    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.backgroundColor = UIColor(red: 33 / 255, green: 33 / 255, blue: 33 / 255, alpha: 1)
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(
                red: 142 / 255,
                green: 142 / 255,
                blue: 143 / 255,
                alpha: 1
            )],
            for: .normal
        )
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(
                red: 18 / 255,
                green: 18 / 255,
                blue: 18 / 255,
                alpha: 1
            )],
            for: .selected
        )
        return segmentedControl
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        selectionStyle = .none
        overlayFirstLayer()
        overlaySecondLayer()
    }

    func setup(text: String, items: [String]) {
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        label.text = text
        for index in 0 ..< items.count {
            segmentedControl.insertSegment(withTitle: items[index], at: index, animated: true)
        }
        segmentedControl.selectedSegmentIndex = 0
    }

    @objc
    private func segmentedValueChanged(_ sender: UISegmentedControl) {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout Constraints

private extension SettingsTableViewCell {
    private func overlaySecondLayer() {
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(segmentedControl)

        NSLayoutConstraint.activate([
            segmentedControl.widthAnchor.constraint(equalToConstant: 120)
        ])
    }

    private func overlayFirstLayer() {
        contentView.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])

    }
}

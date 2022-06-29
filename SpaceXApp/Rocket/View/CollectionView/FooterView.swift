//
//  FooterView.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 07.06.2022.
//

import UIKit

final class FooterView: UICollectionReusableView {

    let launchesButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.buttonSize = .medium
        config.cornerStyle = .medium
        config.baseBackgroundColor = UIColor(named: "DarkGray")
        button.configuration = config
        let mySelectedAttributedTitle = NSAttributedString(
            string: "Посмотреть запуски",
            attributes: [.font: UIFont.boldSystemFont(ofSize: 18)]
        )
        button.setAttributedTitle(mySelectedAttributedTitle, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 25
        backgroundColor = .black
        setHierarchy()
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Layout

private extension FooterView {
    func setHierarchy() {
        addSubview(launchesButton)
    }

    func setLayout() {
        NSLayoutConstraint.activate([
            launchesButton.topAnchor.constraint(equalTo: topAnchor),
            launchesButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            launchesButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            launchesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25)
        ])
    }
}

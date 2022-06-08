//
//  SectionHeaderView.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 06.06.2022.
//

import UIKit

final class SectionHeaderView: UICollectionReusableView {

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        overlayFirstLayer()
    }

    func configure(with title: String) {
        label.text = title
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout Constraints

private extension SectionHeaderView {
    func overlayFirstLayer() {
        addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

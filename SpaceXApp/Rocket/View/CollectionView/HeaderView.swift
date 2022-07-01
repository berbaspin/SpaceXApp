//
//  HeaderView.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 01.06.2022.
//

import RxCocoa
import RxSwift
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

    private let settingsButton: UIButton = {
        let button = UIButton(type: .system)

        let image = UIImage(
            systemName: "gearshape",
            withConfiguration: UIImage.SymbolConfiguration(scale: .large)
        )?.withTintColor(
            UIColor(named: "LightGray") ?? UIColor.lightGray,
            renderingMode: .alwaysOriginal
        )
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 25
        backgroundColor = .black
        setHierarchy()
        setLayout()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    func setup(with title: String, buttonAction: @escaping () -> Void) {
        titleLabel.text = title
        settingsButton.rx
            .tap
            .bind {
                buttonAction()
            }
            .disposed(by: self.disposeBag)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Layout

private extension HeaderView {
    func setHierarchy() {
        addSubview(stackView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(settingsButton)
    }

    func setLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
        NSLayoutConstraint.activate([
            settingsButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}

//
//  SettingsTableViewCell.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 30.05.2022.
//

import RxCocoa
import RxSwift
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
        segmentedControl.backgroundColor = UIColor(named: "DarkGray")
        segmentedControl.setTitleTextAttributes(
            [.foregroundColor: UIColor(named: "Gray") ?? UIColor.darkGray],
            for: .normal
        )
        segmentedControl.setTitleTextAttributes(
            [.foregroundColor: UIColor(named: "Black") ?? UIColor.black],
            for: .selected
        )
        return segmentedControl
    }()

    private let disposeBag = DisposeBag()
    let isUs = PublishSubject<Bool>()
    let changedSegmentedControl = PublishSubject<(Int, Bool)>()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        selectionStyle = .none
        setHierarchy()
        setLayout()
        setupSegmentedControl()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        segmentedControl.removeAllSegments()
    }

    func setup(tag: Int, text: String, items: [Setting.Units], isUs: Bool) {
        label.text = text
        for index in 0 ..< items.count {
            segmentedControl.insertSegment(withTitle: items[index].rawValue, at: index, animated: false)
        }
        segmentedControl.tag = tag
        segmentedControl.selectedSegmentIndex = isUs ? 1 : 0
    }

    private func setupSegmentedControl() {
        segmentedControl.rx
            .selectedSegmentIndex
            .subscribe(onNext: { [weak self] index in
                guard let self = self else {
                    return
                }
                self.isUs.onNext(index == 1)
                self.changedSegmentedControl.onNext((self.segmentedControl.tag, index == 1))

            })
            .disposed(by: disposeBag)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Layout

private extension SettingsTableViewCell {
    func setHierarchy() {
        contentView.addSubview(stack)

        stack.addArrangedSubview(label)
        stack.addArrangedSubview(segmentedControl)
    }

    func setLayout() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])

        NSLayoutConstraint.activate([
            segmentedControl.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
}

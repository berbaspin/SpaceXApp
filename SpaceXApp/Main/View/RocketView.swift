//
//  RocketView.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 08.06.2022.
//

import UIKit
import RxSwift

final class RocketView: UIView {

    private let rocketImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collection.backgroundColor = .black
        collection.layer.cornerRadius = 25
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    private enum Syplementary: String, CaseIterable {
        case globalHeader = "global-header-element-kind"
        case globalFooter = "global-footer-element-kind"
        case sectionHeader = "section-header-element-kind"
    }

    private enum Section: String, CaseIterable {
        case parameters
        case information
        case firstStage = "ПЕРВАЯ СТУПЕНЬ"
        case secondStage = "ВТОРАЯ СТУПЕНЬ"
    }

    private var dataSource: UICollectionViewDiffableDataSource<Section, Cell>! = nil
    private let sections = Section.allCases
    private var viewController: UIViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)
        overlayFirstLayout()
        setupCollectionView()
        createDataSource()
    }

    func configure(viewController: UIViewController, image: UIImage?) {
        self.viewController = viewController
        rocketImage.image = image
    }

    private func setupCollectionView() {
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.register(
            ParametersCell.self,
            forCellWithReuseIdentifier: String(describing: ParametersCell.self)
        )
        collectionView.register(
            InformationCell.self,
            forCellWithReuseIdentifier: String(describing: InformationCell.self)
        )
        collectionView.register(
            StageCell.self,
            forCellWithReuseIdentifier: String(describing: StageCell.self)
        )

        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: Syplementary.sectionHeader.rawValue,
            withReuseIdentifier: String(describing: SectionHeaderView.self)
        )
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: Syplementary.globalHeader.rawValue,
            withReuseIdentifier: String(describing: HeaderView.self)
        )
        collectionView.register(
            FooterView.self,
            forSupplementaryViewOfKind: Syplementary.globalFooter.rawValue,
            withReuseIdentifier: String(describing: FooterView.self)
        )
    }

    // TODO(Move to Router)
    @objc
    private func showLaunches() {
        let launchesViewController = LaunchesViewController()
        viewController?.show(launchesViewController, sender: self)
    }

    // TODO(Move to Router)
    @objc
    private func showSettings() {
        let settingsViewController = SettingsViewController()
        settingsViewController.modalPresentationStyle = .automatic
        viewController?.present(settingsViewController, animated: true)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout Constraints

private extension RocketView {

    func overlayFirstLayout() {
        addSubview(rocketImage)
        addSubview(collectionView)

        NSLayoutConstraint.activate([
            rocketImage.topAnchor.constraint(equalTo: topAnchor),
            rocketImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            rocketImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            rocketImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1 / 3),

            collectionView.topAnchor.constraint(equalTo: rocketImage.bottomAnchor, constant: -25),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}

// MARK: - UICollectionView

private extension RocketView {
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Cell>(
            collectionView: collectionView) { collectionView, indexPath, cellData -> UICollectionViewCell? in

                // TODO(make shorter)
                switch self.sections[indexPath.section] {
                case .parameters:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: String(describing: ParametersCell.self),
                        for: indexPath
                    ) as? ParametersCell
                    cell?.configure(with: cellData)
                    return cell
                case .information:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: String(describing: InformationCell.self),
                        for: indexPath
                    ) as? InformationCell
                    cell?.configure(with: cellData)
                    return cell
                case .firstStage:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: String(describing: StageCell.self),
                        for: indexPath
                    ) as? StageCell
                    cell?.configure(with: cellData)
                    return cell
                case .secondStage:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: String(describing: StageCell.self),
                        for: indexPath
                    ) as? StageCell
                    cell?.configure(with: cellData)
                    return cell
                }
        }

        dataSource.supplementaryViewProvider = {(collectionView: UICollectionView, kind: String, indexPath: IndexPath
            ) -> UICollectionReusableView? in
            // TODO (make shorter)
            switch kind {
            case Syplementary.globalHeader.rawValue:
                let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: String(describing: HeaderView.self),
                    for: indexPath
                ) as? HeaderView
                supplementaryView?.configure(with: "Falcon Heavy")
                supplementaryView?.settingsButton.addTarget(
                    self,
                    action: #selector(self.showSettings),
                    for: .touchUpInside
                )
                return supplementaryView
            case Syplementary.globalFooter.rawValue:
                let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: String(describing: FooterView.self),
                    for: indexPath
                ) as? FooterView
                supplementaryView?.launchesButton.addTarget(
                    self,
                    action: #selector(self.showLaunches),
                    for: .touchUpInside
                )
                return supplementaryView
            default:
                let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: String(describing: SectionHeaderView.self),
                    for: indexPath
                ) as? SectionHeaderView
                supplementaryView?.configure(with: Section.allCases[indexPath.section].rawValue)
                return supplementaryView
            }
        }

        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot)
    }

    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            let section = self.sections[sectionIndex]

            switch section {
            case .parameters:
                return self.createParametersSection()
            case .information:
                return self.createInformationSection()
            case .firstStage:
                return self.createStageSection()
            case .secondStage:
                return self.createStageSection()
            }
        }

        let globalHeaderSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )
        let globalHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: globalHeaderSize,
            elementKind: Syplementary.globalHeader.rawValue,
            alignment: .top
        )

        let globalFooterSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1 / 10)
        )
        let globalFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: globalFooterSize,
            elementKind: Syplementary.globalFooter.rawValue,
            alignment: .bottom
        )

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.boundarySupplementaryItems = [globalHeader, globalFooter]
        layout.configuration = config

        return layout
    }

    private func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, Cell> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Cell>()
        snapshot.appendSections(sections)

        // TODO(change data getting)
        let parameters = [
            Cell(title: "Высота, ft", value: "229.6", measuringSystem: "ft"),
            Cell(title: "Диаметр, ft", value: "39.9", measuringSystem: "ft"),
            Cell(title: "Масса, lb", value: "3,125,735", measuringSystem: "lb"),
            Cell(title: "Нагрузка, lb", value: "140,660", measuringSystem: "lb")
        ]

        let information = [
            Cell(title: "Первый запуск", value: "7 февраля, 2018", measuringSystem: ""),
            Cell(title: "Страна", value: "США", measuringSystem: ""),
            Cell(title: "Стоимость запуска", value: "$90 млн", measuringSystem: "$")
        ]

        let firstStage = [
            Cell(title: "Количество двигателей", value: "27", measuringSystem: ""),
            Cell(title: "Количество топлива", value: "308,6", measuringSystem: "ton"),
            Cell(title: "Время сгорания", value: "593", measuringSystem: "sec")
        ]

        let secondStage = [
            Cell(title: "Количество двигателей", value: "1", measuringSystem: ""),
            Cell(title: "Количество топлива", value: "243,2", measuringSystem: "ton"),
            Cell(title: "Время сгорания", value: "397", measuringSystem: "sec")
        ]

        snapshot.appendItems(parameters, toSection: Section.parameters)
        snapshot.appendItems(information, toSection: Section.information)
        snapshot.appendItems(firstStage, toSection: Section.firstStage)
        snapshot.appendItems(secondStage, toSection: Section.secondStage)

        return snapshot
    }
}

// MARK: - UICollectionView Sections

private extension RocketView {
    func createParametersSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(104),
            heightDimension: .estimated(44)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 25)
        return section
    }

    func createInformationSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1 / 15)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 25, bottom: 30, trailing: 25)
        return section
    }

    func createStageSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1 / 15)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: Syplementary.sectionHeader.rawValue,
            alignment: .top
        )

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 25, bottom: 30, trailing: 25)
        return section
    }
}

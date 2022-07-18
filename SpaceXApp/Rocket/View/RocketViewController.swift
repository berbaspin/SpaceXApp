//
//  RocketViewController.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 08.06.2022.
//

import RxCocoa
import RxSwift
import UIKit

final class RocketViewController: UIViewController {

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

    // swiftlint:disable:next implicitly_unwrapped_optional
    private var dataSource: UICollectionViewDiffableDataSource<Section, RocketCellModel>! = nil
    private let viewModel: RocketViewModelProtocol
    private let disposeBag = DisposeBag()
    let pageIndex: Int

    init(viewModel: RocketViewModel, pageIndex: Int) {
        self.viewModel = viewModel
        self.pageIndex = pageIndex
        super.init(nibName: nil, bundle: nil)
        viewModel.setData()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setHierarchy()
        setLayout()
        bind()
        setupCollectionView()
        createDataSource()
    }

    private func bind() {
        viewModel.imageDataSource
            .asObservable()
            .bind(to: rocketImage.rx.image)
            .disposed(by: disposeBag)

    }

    private func setupCollectionView() {
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.registerCell(type: ParametersCell.self)
        collectionView.registerCell(type: InformationCell.self)
        collectionView.registerCell(type: StageCell.self)
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
}

// MARK: - Setup Layout

private extension RocketViewController {
    func setHierarchy() {
        [rocketImage, collectionView].forEach(view.addSubview)
    }

    func setLayout() {
        NSLayoutConstraint.activate([
            rocketImage.topAnchor.constraint(equalTo: view.topAnchor),
            rocketImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rocketImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rocketImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 3),

            collectionView.topAnchor.constraint(equalTo: rocketImage.bottomAnchor, constant: -25),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionView

private extension RocketViewController {
    func createDataSource() {
        dataSource = createCollectionViewDiffableDataSource()
        dataSource.supplementaryViewProvider = createCollectionViewSupplementaryViewProvider()

        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot)
    }

    private func createCollectionViewDiffableDataSource() ->
    UICollectionViewDiffableDataSource<Section, RocketCellModel> {
        UICollectionViewDiffableDataSource<Section, RocketCellModel>(
            collectionView: collectionView) { collectionView, indexPath, cellData -> UICollectionViewCell? in
                let section = self.viewModel.dataSource[indexPath.section]
                // TODO: make shorter
                switch section.type {
                case .parameters:
                    let cell = collectionView.dequeueCell(
                        type: ParametersCell.self, for: indexPath
                    ) as? ParametersCell
                    cell?.setup(with: cellData)
                    return cell
                case .information:
                    let cell = collectionView.dequeueCell(
                        type: InformationCell.self, for: indexPath
                    ) as? InformationCell
                    cell?.setup(with: cellData)
                    return cell
                case .firstStage:
                    let cell = collectionView.dequeueCell(type: StageCell.self, for: indexPath) as? StageCell
                    cell?.setup(with: cellData)
                    return cell
                case .secondStage:
                    let cell = collectionView.dequeueCell(type: StageCell.self, for: indexPath) as? StageCell
                    cell?.setup(with: cellData)
                    return cell
                }
        }
    }

    func createCollectionViewSupplementaryViewProvider() ->
    ((UICollectionView, String, IndexPath) -> UICollectionReusableView?) {
        { collectionView, kind, indexPath -> UICollectionReusableView? in
            switch kind {
            case Syplementary.globalHeader.rawValue:
                let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: String(describing: HeaderView.self),
                    for: indexPath
                ) as? HeaderView
                supplementaryView?.setup(with: self.viewModel.name, buttonAction: self.viewModel.tapOnSettings)
                return supplementaryView
            case Syplementary.globalFooter.rawValue:
                let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: String(describing: FooterView.self),
                    for: indexPath
                ) as? FooterView
                supplementaryView?.setup(buttonAction: self.viewModel.tapOnLaunches)
                return supplementaryView
            default:
                let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: String(describing: SectionHeaderView.self),
                    for: indexPath
                ) as? SectionHeaderView
                supplementaryView?.setup(with: self.viewModel.dataSource[indexPath.section].type.name)
                return supplementaryView
            }
        }
    }

    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            let section = self.viewModel.dataSource[sectionIndex]
            switch section.type {
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

    private func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, RocketCellModel> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, RocketCellModel>()
        let sections = viewModel.dataSource
        snapshot.appendSections(sections)

        sections.forEach { snapshot.appendItems($0.cellModels, toSection: $0) }
        return snapshot
    }

}

// MARK: - UICollectionView Sections

private extension RocketViewController {
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

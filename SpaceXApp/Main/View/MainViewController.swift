//
//  MainViewController.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 01.06.2022.
//

import RxCocoa
import RxSwift
import UIKit

final class MainViewController: UIPageViewController {

    private var currentIndex: Int = 0
    private var rocketViewControllers = [RocketViewController]()
    private let disposeBag = DisposeBag()
    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: MainViewModelProtocol!

    override init(
        transitionStyle style: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        options: [UIPageViewController.OptionsKey : Any]? = nil
    ) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        view.backgroundColor = .black
        bind()
    }

    private func bind() {
        viewModel.dataSourse
            .map { rockets -> [RocketViewController] in
                rockets
                    .enumerated()
                    .map { index, rocketViewModel in
                        RocketViewController(
                            viewModel: rocketViewModel,
                            pageIndex: index
                        )
                    }
            }
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] viewControllers in
                self?.rocketViewControllers = viewControllers
                guard let initialVC = self?.rocketViewControllers.first else {
                    return
                }
                self?.setViewControllers([initialVC], direction: .forward, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UIPageViewControllerDataSource

extension MainViewController: UIPageViewControllerDataSource {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let currentViewController = viewController as? RocketViewController else {
            return nil
        }

        var index = currentViewController.pageIndex
        if index == 0 {
            return nil
        }
        index -= 1

        return rocketViewControllers[index]
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let currentViewController = viewController as? RocketViewController else {
            return nil
        }

        var index = currentViewController.pageIndex
        if index >= rocketViewControllers.count - 1 {
            return nil
        }
        index += 1

        return rocketViewControllers[index]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        rocketViewControllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        currentIndex
    }
}

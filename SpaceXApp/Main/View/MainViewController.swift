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

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        view.backgroundColor = .black
        viewModel.getData()
        bind()
    }
}

// MARK: Data binding

private extension MainViewController {
    func bind() {
        // swiftlint:disable:next trailing_closure
        viewModel.dataSource
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
            .drive(onNext: { [weak self] viewControllers in
                guard let self = self else {
                    return
                }
                self.rocketViewControllers = viewControllers
                let initialVC = self.rocketViewControllers[self.currentIndex]
                self.setViewControllers([initialVC], direction: .forward, animated: false)
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
        guard let currentViewController = viewController as? RocketViewController,
            currentViewController.pageIndex != 0 else {
            return nil
        }
        return rocketViewControllers[currentViewController.pageIndex - 1]
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let currentViewController = viewController as? RocketViewController,
            currentViewController.pageIndex < rocketViewControllers.count - 1 else {
            return nil
        }
        return rocketViewControllers[currentViewController.pageIndex + 1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        rocketViewControllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        currentIndex
    }
}

// MARK: - UIPageViewControllerDelegate

extension MainViewController: UIPageViewControllerDelegate {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        guard completed,
            let currentVC = pageViewController.viewControllers?.first as? RocketViewController else {
            return
        }
        currentIndex = currentVC.pageIndex
    }
}

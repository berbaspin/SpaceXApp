//
//  MainViewController.swift
//  SpaceXApp
//
//  Created by Dmitry Babaev on 01.06.2022.
//

import UIKit

final class MainViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        // scrollView.showsHorizontalScrollIndicator = false
        // scrollView.isScrollEnabled = true
        scrollView.isDirectionalLockEnabled = true
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()

    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        // stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        // stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let rocketView: RocketView = {
        let view = RocketView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let rocketCopyView: RocketView = {
        let view = RocketView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var views = [RocketView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configure()
    }

    private func configure() {
        views = [rocketView, rocketCopyView]
        rocketView.configure(viewController: self, image: UIImage(named: "rocket"))
        rocketCopyView.configure(viewController: self, image: UIImage(named: "rocket"))
        overlayFirstLayer()
        overlaySecondLayer()
        overlayThirdLayer()
        configurePageControl()
    }

    private func configurePageControl() {
        pageControl.numberOfPages = views.count
        pageControl.addTarget(
            self,
            action: #selector(pageControlTapped),
            for: .valueChanged
        )
    }

    @objc
    private func pageControlTapped(sender: UIPageControl) {
        scrollView.delegate = self

        let pageWidth = scrollView.bounds.width
        let offset = sender.currentPage * Int(pageWidth)

        UIView.animate(withDuration: 0.33) { [weak self] in
            self?.scrollView.contentOffset.x = CGFloat(offset)
        }
    }
}

// MARK: - Layout Constraints

private extension MainViewController {

    func overlayThirdLayer() {
        views.forEach { view in
            stackView.addArrangedSubview(view)
            view.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
            view.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        }
    }

    func overlaySecondLayer() {
        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
    }

    func overlayFirstLayer() {
        view.addSubview(scrollView)
        view.addSubview(pageControl)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 10 / 11),

            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 2)
        ])
    }

}

// MARK: - UIScrollViewDelegate

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let pageFraction = scrollView.contentOffset.x / pageWidth

        pageControl.currentPage = Int((round(pageFraction)))
    }
}

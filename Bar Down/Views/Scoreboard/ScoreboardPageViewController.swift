//
//  ScoreboardPageViewController.swift
//  Bar Down
//
//  Created by Alex King on 9/8/19.
//  Copyright © 2019 Pryanik. All rights reserved.
//

import Foundation
import UIKit

class ScoreboardPageViewController: UIPageViewController {
        
    init() {
        super.init(transitionStyle: .scroll,
                   navigationOrientation: .horizontal,
                   options: nil)
        dataSource = self
        delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        setViewControllers([ScoreboardViewController()], direction: .forward, animated: false, completion: nil)
        updateTitle()
    }
    
    private func updateTitle() {
        guard let scoreboardViewController = viewControllers?.first as? ScoreboardViewController else {
            return
        }
        title = scoreboardViewController.title
    }
}

extension ScoreboardPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard
            let scoreboardViewController = viewController as? ScoreboardViewController,
            let newDate = Calendar.current.date(byAdding: .day, value: -1, to: scoreboardViewController.date)
        else {
            return nil
        }
        return ScoreboardViewController(date: newDate)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard
            let scoreboardViewController = viewController as? ScoreboardViewController,
            let newDate = Calendar.current.date(byAdding: .day, value: 1, to: scoreboardViewController.date)
        else {
            return nil
        }
        return ScoreboardViewController(date: newDate)
    }
    
}

extension ScoreboardPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        updateTitle()
    }
    
}

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
        title = "Bar Down"
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        setViewControllers([ScoreboardViewController()], direction: .forward, animated: false, completion: nil)
    }
    
}

extension ScoreboardPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return ScoreboardViewController()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return ScoreboardViewController()
    }
    
}

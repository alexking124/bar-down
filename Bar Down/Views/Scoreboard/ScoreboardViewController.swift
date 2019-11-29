//
//  ScoreboardViewController.swift
//  Bar Down
//
//  Created by Alex King on 9/8/19.
//  Copyright © 2019 Pryanik. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import UIKit
import CoreData

class ScoreboardViewController: UIViewController {
    
    let date: Date
    
    init?(date: Date = Date()) {
        self.date = date
        super.init(nibName: nil, bundle: nil)
        title = DateFormatter(format: .displayDate).string(from: date)
    }
    
    @available(*, unavailable)
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var hostingController: UIViewController = {
        let context = PersistenceManager.shared.viewContext
        let hostingController = UIHostingController(rootView: ContentView(date: date).environment(\.managedObjectContext, context))
        return hostingController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            hostingController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        hostingController.didMove(toParent: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        NetworkDispatch.shared.fetchSchedule(date: date)
    }
    
}

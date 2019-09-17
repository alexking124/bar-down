//
//  ScoreboardViewController.swift
//  Bar Down
//
//  Created by Alex King on 9/8/19.
//  Copyright © 2019 Pryanik. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

class ScoreboardViewController: UIHostingController<ContentView> {
    
    private let date: Date

    init(date: Date = Date()) {
        self.date = date
        super.init(rootView: ContentView())
    }
    
    @available(*, unavailable)
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

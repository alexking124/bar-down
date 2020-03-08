//
//  CollectionExt.swift
//  Bar Down
//
//  Created by Alex King on 2/22/20.
//  Copyright © 2020 Pryanik. All rights reserved.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

//
//  StrengthCode.swift
//  Bar Down
//
//  Created by Alex King on 2/5/21.
//  Copyright © 2021 Pryanik. All rights reserved.
//

import Foundation

enum StrengthCode: String {

    case even = "EVEN"
    case powerPlay = "PPG"
    case shorthanded = "SHG"

    init(code: String) {
        self = StrengthCode(rawValue: code) ?? .even
    }
}

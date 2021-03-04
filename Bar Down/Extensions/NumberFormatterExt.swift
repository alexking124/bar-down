//
//  NumberFormatterExt.swift
//  Bar Down
//
//  Created by Alex King on 2/22/21.
//  Copyright © 2021 Pryanik. All rights reserved.
//

import Foundation

extension NumberFormatter {
    static var ordinalFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter
    }
}

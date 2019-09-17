//
//  DateFormatterExt.swift
//  Bar Down
//
//  Created by Alex King on 9/8/19.
//  Copyright © 2019 Pryanik. All rights reserved.
//

import Foundation

enum BarDownDateFormat: String {
    case yearMonthDay = "yyyy-MM-dd"
    case gameClock = "h:mm a"
}

extension DateFormatter {
    
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
    
    func withCurrentLocale() -> DateFormatter {
        let formatter = self
        formatter.locale = Locale.current
        return formatter
    }
}

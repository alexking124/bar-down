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
    case displayDate = "EEE, MMM dd yyyy"
}

extension DateFormatter {
    
    static let gameDateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = .withInternetDateTime
        return formatter
    }()
    
    static let scheduledGameTimeFormatter: DateFormatter = {
        let formatter = DateFormatter().withCurrentLocale()
        formatter.dateFormat = BarDownDateFormat.gameClock.rawValue
        return formatter
    }()
    
    convenience init(format: BarDownDateFormat) {
        self.init(dateFormat: format.rawValue)
    }
    
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

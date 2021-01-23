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
    case scheduledTime = "h:mm a"
    case displayDate = "EEE, MMM dd yyyy"
  case intermissionClockTime = "m:ss"
}

extension DateFormatter {
    
    static let gameDateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = .withInternetDateTime
        return formatter
    }()
    
    static let scheduledGameTimeFormatter: DateFormatter = {
      DateFormatter(format: .scheduledTime).withCurrentLocale()
    }()

  static let intermissionClockTime: DateFormatter = {
    DateFormatter(format: .intermissionClockTime)
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

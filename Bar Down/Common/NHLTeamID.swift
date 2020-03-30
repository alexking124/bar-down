//
//  NHLTeamID.swift
//  Bar Down
//
//  Created by Alex King on 9/26/19.
//  Copyright © 2019 Pryanik. All rights reserved.
//

import Foundation
import UIKit

enum NHLTeamID: Int, CaseIterable, Identifiable {
    case nhl = 0
    case njd = 1
    case nyi = 2
    case nyr = 3
    case phi = 4
    case pit = 5
    case bos = 6
    case buf = 7
    case mtl = 8
    case ott = 9
    case tor = 10
    case car = 12
    case fla = 13
    case tbl = 14
    case wsh = 15
    case chi = 16
    case det = 17
    case nsh = 18
    case stl = 19
    case cgy = 20
    case col = 21
    case edm = 22
    case van = 23
    case ana = 24
    case dal = 25
    case lak = 26
    case sjs = 28
    case cbj = 29
    case min = 30
    case wpg = 52
    case ari = 53
    case vgk = 54
    case atlantic = 87
    case metropolitan = 88
    case central = 89
    case pacific = 90
    
    var id: Int {
        return rawValue
    }
    
    var logo: UIImage? {
        return UIImage(named: imageName)
    }
    
    var imageName: String {
        switch self {
        default:
            return "\(self)"
        }
    }
}

//
//  GameEventType.swift
//  Bar Down
//
//  Created by Alex King on 1/28/21.
//  Copyright © 2021 Pryanik. All rights reserved.
//

import Foundation

enum GameEventType: String {
  case goal = "GOAL"
  case penalty = "PENALTY"
  case shot = "SHOT"
  case hit = "HIT"
  case faceoff = "FACEOFF"
  case stop = "STOP"
  case blockedShot = "BLOCKED_SHOT"
  case missedShot = "MISSED_SHOT"
  case giveaway = "GIVEAWAY"
}

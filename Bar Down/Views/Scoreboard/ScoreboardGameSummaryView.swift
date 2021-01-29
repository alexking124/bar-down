//
//  ScoreboardGameSummaryView.swift
//  Bar Down
//
//  Created by Alex King on 1/27/21.
//  Copyright © 2021 Pryanik. All rights reserved.
//

import Foundation
import SwiftUI

struct ScoreboardGameSummaryView: View {

  @ObservedObject private var game: Game

  init(game: Game) {
    self.game = game
  }

  var body: some View {
    VStack {
      GameSummaryTopContentRow(game: game)
      GameSummaryBottomContentRow(game: game)
    }.padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
  }
}

fileprivate struct GameSummaryTopContentRow: View {

  @ObservedObject private var game: Game

  init(game: Game) {
    self.game = game
  }

  var body: some View {
    HStack {
      HStack {
        Image(game.awayTeam?.nhlTeamID.imageName ?? "nhl").resizable().scaledToFit()
        Spacer()
      }.frame(width: 84, height: 70)
      Spacer()
      VStack(alignment: .center, spacing: 2) {
        Text(game.scoreboardPrimaryText).font(.system(size: 18, weight: .medium))
        Text(game.scoreboardSecondaryText).font(.system(size: 14, weight: .light))
        if let ppStrength = game.powerPlayStrength, game.powerPlaySecondsRemaining > 0 {
          Text(ppStrength).font(.system(size: 14, weight: .light))
        }
      }
      Spacer()
      HStack {
        Spacer()
        Image(game.homeTeam?.nhlTeamID.imageName ?? "nhl").resizable().scaledToFit()
      }.frame(width: 84, height: 70)
    }
  }

}

fileprivate struct GameSummaryBottomContentRow: View {

  @ObservedObject private var game: Game

  init(game: Game) {
    self.game = game
  }

  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 0) {
        Text(game.awayTeam?.locationName ?? "")
            .font(Font.system(size: 11, weight: .semibold, design: .default))
        Text(game.awayTeam?.teamName ?? "")
            .font(Font.system(size: 15, weight: .light, design: .default))
      }
      Spacer()
      VStack(alignment: .trailing, spacing: 0) {
        Text(game.homeTeam?.locationName ?? "")
            .font(Font.system(size: 11, weight: .semibold, design: .default))
        Text(game.homeTeam?.teamName ?? "")
            .font(Font.system(size: 15, weight: .light, design: .default))
      }
    }
  }

}

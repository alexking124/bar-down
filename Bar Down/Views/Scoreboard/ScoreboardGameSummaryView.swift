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
            if let gameLabel = game.seriesGameLabel, let seriesStatus = game.seriesStatus {
                GameSummarySeriesStatusRow(text: "\(gameLabel) | \(seriesStatus)")
            }
        }
        .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
        .contentShape(Rectangle())
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
                if let tertiaryText = game.scoreboardTertiaryText {
                    Text(tertiaryText).font(.system(size: 12, weight: .regular))
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
                Text(game.hasStarted ? "\(game.awayTeamShots) SOG" : game.awayTeam?.locationName ?? "")
                    .font(Font.system(size: 11, weight: .semibold, design: .default))
                HStack {
                    Text(game.awayTeam?.teamName ?? "")
                        .font(Font.system(size: 15, weight: .light, design: .default))
                    if game.awayPowerPlay && game.isInProgress {
                        SkaterDifferentialStatusView(text: "PP")
                    }
                    if game.awayGoaliePulled && game.isInProgress {
                        SkaterDifferentialStatusView(text: "EN")
                    }
                }
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 0) {
                Text(game.hasStarted ? "\(game.homeTeamShots) SOG" : game.homeTeam?.locationName ?? "")
                    .font(Font.system(size: 11, weight: .semibold, design: .default))
                HStack {
                    if game.homeGoaliePulled && game.isInProgress {
                        SkaterDifferentialStatusView(text: "EN")
                    }
                    if game.homePowerPlay && game.isInProgress {
                        SkaterDifferentialStatusView(text: "PP")
                    }
                    Text(game.homeTeam?.teamName ?? "")
                        .font(Font.system(size: 15, weight: .light, design: .default))
                }
            }
        }
    }

}

fileprivate struct SkaterDifferentialStatusView: View {
    let text: String

    var body: some View {
        Text(text)
            .font(Font.system(size: 10, weight: .bold, design: .default))
            .padding(3)
            .background(Color.blue.opacity(0.75))
            .cornerRadius(4)
    }
}

fileprivate struct GameSummarySeriesStatusRow: View {

    private let seriesStatusText: String
    init(text: String) {
        self.seriesStatusText = text
    }

    var body: some View {
        Text(seriesStatusText)
            .font(Font.system(size: 11, weight: .semibold, design: .default))
    }

}

//
//  GameDetailsSectionHeader.swift
//  Bar Down
//
//  Created by Alex King on 2/22/20.
//  Copyright © 2020 Pryanik. All rights reserved.
//

import Foundation
import SwiftUI

struct GameDetailsSectionHeader: View {
    
    private let title: String
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Text(title)
                    .font(Font.system(size: 22, weight: .regular))
                Spacer()
            }
            Divider()
        }.padding([.top, .leading, .trailing])
    }
}

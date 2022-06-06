//
//  EmojiView.swift
//  coffee-sample
//
//  Created by Alex Logan on 06/06/2022.
//

import SwiftUI

struct EmojiView: View {
    let moji: Emoji

    var body: some View {
        Text(moji.moji)
            .font(.largeTitle)
    }
}

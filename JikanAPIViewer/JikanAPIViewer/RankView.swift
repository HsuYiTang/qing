//
//  RankView.swift
//  JikanAPIViewer
//
//  Created by 徐翊棠 on 2024/1/6.
//

import Foundation
import SwiftUI

struct rankView: View {
    var rank: Int
    var body: some View{
        Text("\(rank)")
            .fontWeight(rank <= 3 ? .bold : nil)
            .font(rank <= 3 ? .title : .callout)
            .frame(width: 40, height: 20)
            .padding()
            .foregroundColor(.white).background{
                RoundedRectangle(cornerRadius: 20).foregroundStyle(RankViewBackgroundColor(rank))
            }
    }
}

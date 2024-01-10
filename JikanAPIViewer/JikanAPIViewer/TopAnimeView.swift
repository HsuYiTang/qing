//
//  TopAnimeView.swift
//  JikanAPIViewer
//
//  Created by 徐翊棠 on 2024/1/4.
//

import Foundation
import SwiftUI

struct TopAnimeView: View{
    @EnvironmentObject private var viewModel: TopAnimeViewModel
    @EnvironmentObject private var animeSearchViewModel: AnimeSearchViewModel
    var body: some View{
        //NavigationView {
            ZStack {
                AnimeList
                ProgressView()
                    .opacity(viewModel.isLoading ? 1.0: 0.0)
            }.navigationBarTitleDisplayMode(.inline)
                .navigationTitle("首頁")
                .refreshable {
                    viewModel.refreshCurrentList()
                }
                .onAppear() {
                    viewModel.initTopAnimeList()
                }
                .navigationViewStyle(StackNavigationViewStyle())
            
        //}
    }
    var AnimeList: some View{
        List{
            ForEach(viewModel.topAnimeList,id: \.id){ item in
                NavigationLink {
                    if let anime = item{
                        AnimeDetailsView(item: anime)
                    }
                } label: {
                    AnimeItemView(item: item)
                }.onAppear() {
                    if (viewModel.topAnimeList.last == item) {
                        viewModel.fetchNextAnimePage()
                    }
                }
            }
        }
    }
}
struct TopAnimeView_Previews: PreviewProvider {
    static var previews: some View {
        TopAnimeView()
            .environmentObject(TopAnimeViewModel())
    }
}

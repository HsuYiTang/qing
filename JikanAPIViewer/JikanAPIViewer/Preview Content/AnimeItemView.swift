//
//  AnimeItemView.swift
//  JikanAPIViewer
//
//  Created by 徐翊棠 on 2024/1/4.
//

import Foundation
import SwiftUI

struct AnimeItemView: View{
    var item: Anime
    var showRank = true
    var body: some View{
        HStack{
            rankView(rank: Int(item.rank ?? 0))
                .opacity(showRank ? 1.0 : 0.0)
            let url = URL(string: item.images?["jpg"]?.imageURL ?? "")!
            AsyncImage(url: url,content:{ image in
                image.resizable()
                     .aspectRatio(contentMode: .fit)
                     .frame(maxWidth: 80, maxHeight: 100)
            },placeholder: {
                ProgressView()
            })
            VStack(alignment: .leading) {
                Text("\(item.titleJapanese ?? "")")
                    .lineLimit(3)
                    .font(.system(size: 18,weight: .heavy))
                Text("類型：\(item.type ?? "")")
                    .font(.system(size: 14))
                Text(item.type == "Movie" ? "上映日期：\(item.aired?.from?.dateFormated() ?? "")" : "播放日期：\(item.aired?.from?.dateFormated() ?? "") ~ \(item.aired?.to?.dateFormated() ?? "To be continued")")
                    .font(.system(size: 14))
                    .lineLimit(3)
                Text("評分：\(item.score ?? 0.0, specifier: "%.2f")")
                    .font(.system(size: 14))
            }
        }
    }
}
struct AnimeItemView_Previews: PreviewProvider {
    static var previews: some View {
        AnimeItemView(item: Anime(id: 123, url: "https://myanimelist.net/anime/5114/Fullmetal_Alchemist__Brotherhood", images: ["jpg": CoverImage(imageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg", smallImageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg", largeImageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg")], trailer: nil, title: "test", titleEnglish: "test", titleJapanese: "測試", titleSynonyms: nil, type: nil, source: nil, episodes: nil, status: nil, airing: nil, aired: nil, duration: nil, rating: nil, score: 5.0, scoredBy: nil, rank: 1.0, popularity: nil, members: nil, favorites: nil, synopsis: nil, background: nil, season: nil, year: nil, broadcast: nil, producers: nil, licensors: nil, studios: nil, genres: nil, explicitGenres: nil, themes: nil, demographics: nil))
    }
}

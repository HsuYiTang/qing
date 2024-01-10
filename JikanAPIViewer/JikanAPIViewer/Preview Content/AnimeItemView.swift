import Foundation
import SwiftUI
import Marquee

struct AnimeItemView: View{
    let animatioEffect = Animation.linear(duration: 3)
    var item: Anime
    var showRank = true
    @State var 位移 = 200.0
    var body: some View{
            HStack{
                rankView(rank: Int(item.rank ?? 0))
                    .opacity(showRank ? 1.0 : 0.0)
                let url = URL(string: item.images?["jpg"]?.imageURL ?? "")!
                AsyncImage(url: url,content:{ image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(/*maxWidth: 80, */minHeight: 80, maxHeight: 100)
                },placeholder: {
                    ProgressView()
                        .aspectRatio(contentMode: .fit)
                        .frame( maxWidth: 80, maxHeight: 100)
                })
                VStack(alignment: .leading) {
                    Marquee {
                        Text("\(item.titleJapanese ?? "")")
                            .font(.system(size: 14,weight: .heavy))
                    }
                    .marqueeWhenNotFit(true)
                        .marqueeDuration(5)
                    Text("類型：\(item.type ?? "")")
                        .font(.system(size: 14))
                    Text("評分：\(item.score ?? 0.0, specifier: "%.2f")")
                        .font(.system(size: 14))
                    HStack {
                        Text("日期：")
                            .font(.system(size: 14))
                    Marquee {
                        Text(item.type == "Movie" ? "\(item.aired?.from?.dateFormated() ?? "")" : "\(item.aired?.from?.dateFormated() ?? "") ~ \(item.aired?.to?.dateFormated() ?? "To be continued")")
                                .font(.system(size: 14))
                    }
                        .marqueeWhenNotFit(true)
                        .marqueeDuration(5)
                    }
                }
            }.frame(minHeight: 100)
    }
}
struct AnimeItemView_Previews: PreviewProvider {
    static var previews: some View {
        AnimeItemView(item: Anime(id: 123, url: "https://myanimelist.net/anime/5114/Fullmetal_Alchemist__Brotherhood", images: ["jpg": CoverImage(imageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg", smallImageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg", largeImageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg")], trailer: nil, title: "test", titleEnglish: "test", titleJapanese: "測試", titleSynonyms: nil, type: nil, source: nil, episodes: nil, status: nil, airing: nil, aired: nil, duration: nil, rating: nil, score: 5.0, scoredBy: nil, rank: 1.0, popularity: nil, members: nil, favorites: nil, synopsis: nil, background: nil, season: nil, year: nil, broadcast: nil, producers: nil, licensors: nil, studios: nil, genres: nil, explicitGenres: nil, themes: nil, demographics: nil))
    }
}
//struct 跑馬燈: View {
//    @State var 位移: CGFloat = 450
//    let 動畫效果 = Animation.linear(duration: 10.0)
//    var body: some View {
//        Text(訊息)
//            .foregroundColor(.purple)
//            .font(.system(size: 36))
//            .frame(width: 800.0)
//            .lineLimit(1)
//            .offset(x: 位移, y: 0)
//            .onAppear {
//                withAnimation(動畫效果.repeatForever(autoreverses: false)) {
//                    位移 = -450
//                }
//            }
//    }
//}

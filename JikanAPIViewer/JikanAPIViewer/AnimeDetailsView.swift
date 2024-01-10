import Foundation
import SwiftUI
import Marquee

struct AnimeDetailsView: View {
    @State private var showWebView = false
    let item: Anime
    var body: some View{
        let url = URL(string: item.images?["jpg"]?.largeImageURL ?? "")!
        GeometryReader{ geometry in
            ScrollView{
                VStack{
                    ScrollView([.vertical, .horizontal]){
                        AsyncImage(url: url,content:{ image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width > geometry.size.height ? geometry.size.height * 0.4 * zoomScale : geometry.size.width * 0.4 * zoomScale, height: geometry.size.width > geometry.size.height ? geometry.size.width * 0.4 * zoomScale : geometry.size.height * 0.4 * zoomScale)
                        },placeholder: {
                            ProgressView()
                        })}
                    VStack{
                        VStack{
                            Text("\(item.titleJapanese ?? "")")
                                    .font(.title)
                                    //.fontWeight(.bold)
                            Text("\(item.titleEnglish ?? "")")
                            Text("類型:\(item.type ?? "")")
                        HStack{
                            Text("日期:")
                            Text(item.type == "Movie" ? "\(item.aired?.from?.dateFormated() ?? "")" : "\(item.aired?.from?.dateFormated() ?? "") ~ \(item.aired?.to?.dateFormated() ?? "To be continued")")
                        }.aspectRatio(contentMode: .fit)
                            HStack(alignment: .bottom){
                                Text("排名:\(Int(item.rank ?? 0))")
                                    .font(Int(item.rank ?? 0) <= 3 ? .title : .system(.callout))
                                    .fontWeight(Int(item.rank ?? 0) <= 3 ? .bold : nil)
                                Text("評分: \((item.score ?? 0.0),specifier: "%.2f")")
                                    .foregroundColor( .red)
                            }
                        }
                    }.frame(maxWidth: .infinity)
                    HStack{
                        Text("原作: \(item.source ?? "")").padding()
                    }
                    Text((item.background != nil) ? "描述:\(item.background!)" : "").padding()
                    Button {
                        showWebView.toggle()
                    } label: {
                        Text("在網頁中查看")
                    }
                    .buttonStyle(ButtonView()).sheet(isPresented: $showWebView) {
                        if let urlString = item.url, let url = URL(string: urlString) {
                            SafariView(url: url)
                        }
                    }
                }
            }.gesture(pinch)
        }
    }
    // MARK: - Gesture
    @State private var steadyStateScale: CGFloat = 1.0{
        didSet{
            if oldValue < 1.0 {
                steadyStateScale = 1.0
            }
        }
    }
    @GestureState private var gestureScale: CGFloat = 1.0
    
    private var zoomScale: CGFloat {
        if steadyStateScale * gestureScale <= 1.0{
            return 1.0
        }
        else{
            return steadyStateScale * gestureScale
        }
    }
    
    private var pinch: some Gesture {
        MagnificationGesture()
            .updating($gestureScale) { (latestGestureScale, gestureScale, _) in
                gestureScale = latestGestureScale
            }
            .onEnded { (finalGestureScale) in
                steadyStateScale *= finalGestureScale
            }
    }
}
//        struct AnimeDetailsView_Previews: PreviewProvider {
//            static var previews: some View {
//                AnimeDetailsView(item: Anime(id: 123, url: "https://myanimelist.net/anime/5114/Fullmetal_Alchemist__Brotherhood", images: ["jpg": CoverImage(imageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg", smallImageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg", largeImageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg")], trailer: nil, title: "test", titleEnglish: "test", titleJapanese: "測試", titleSynonyms: nil, type: nil, source: nil, episodes: nil, status: nil, airing: nil, aired: nil, duration: nil, rating: nil, score: 5.0, scoredBy: nil, rank: 1.0, popularity: nil, members: nil, favorites: nil, synopsis: nil, background: nil, season: nil, year: nil, broadcast: nil, producers: nil, licensors: nil, studios: nil, genres: nil, explicitGenres: nil, themes: nil, demographics: nil))
//            }


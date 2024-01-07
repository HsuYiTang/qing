//
//  AnimeDetailsView.swift
//  JikanAPIViewer
//
//  Created by 徐翊棠 on 2024/1/5.
//

import Foundation
import SwiftUI

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
                    HStack{
                        VStack(alignment: .leading){
                            Text("\(item.titleJapanese ?? "")")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("\(item.titleEnglish ?? "")")
                            HStack{
                                Text("Streaming platform:")
                                Text("\(item.type ?? "")")
                            }.aspectRatio(contentMode: .fit)
                            Text("\(item.aired?.from?.dateFormated() ?? "") ~ \(item.aired?.to?.dateFormated() ?? "To be continued")")
                                .font(.system(size: 14))
                            HStack(alignment: .bottom){
                                Text("score: ")
                                Text("\((item.score ?? 5.0),specifier: "%.2f")")
                                    .foregroundColor( .red)
                            }
                        Text("\(zoomScale)")
                        }
                    }.frame(maxWidth: .infinity)
                    HStack{
                        Text("Source: \(item.source ?? "")").padding()
                    }
                    Text("\(item.background ?? "")").padding()
                    Button {
                        showWebView.toggle()
                    } label: {
                        Text("View on Web")
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
            }else if oldValue > 2.5{
                steadyStateScale = 2.5
            }
        }
    }
    @GestureState private var gestureScale: CGFloat = 1.0
    
    private var zoomScale: CGFloat {
        if steadyStateScale * gestureScale <= 1.0{
            return 1.0
        }else if steadyStateScale * gestureScale >= 2.5{
            return 2.5
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


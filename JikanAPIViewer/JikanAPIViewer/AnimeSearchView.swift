import SwiftUI

struct AnimeSearchView: View {
    @EnvironmentObject private var animeSearchViewModel: AnimeSearchViewModel
    var body: some View {
        NavigationView {
            VStack {
                SearchBar().environmentObject(animeSearchViewModel)
                ZStack {
                        AnimeList
                        .opacity(animeSearchViewModel.animeResult.isEmpty ? 0.0: 1.0)
                        
                }.background(){
                    VStack{
                        ProgressView()
                            .opacity(animeSearchViewModel.cache != nil && animeSearchViewModel.isLoading ? 1.0: 0.0)
                        Text((animeSearchViewModel.cache != nil ? animeSearchViewModel.isLoading == false ? "找不到該動畫" : "搜尋中" : "請輸入動畫名稱"))
                    }
                }
                }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("搜尋")
            .refreshable {
                    animeSearchViewModel.refreshCurrentList()
            }
            .onAppear() {
                animeSearchViewModel.initTopAnimeList()
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    var AnimeList: some View{
            List{
                ForEach(animeSearchViewModel.animeResult,id: \.id){ item in
                    NavigationLink {
                        if let anime = item{
                            AnimeDetailsView(item: anime)
                        }
                    } label: {
                        AnimeItemView(item: item)
                    }
                }
            }.onAppear(){
                if (animeSearchViewModel.cache == nil) {
                    animeSearchViewModel.searchAnime(name: "")
                }
        }
    }
}

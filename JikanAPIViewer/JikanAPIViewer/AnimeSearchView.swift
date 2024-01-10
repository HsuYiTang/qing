import SwiftUI

struct AnimeSearchView: View {
    @EnvironmentObject private var animeSearchViewModel: AnimeSearchViewModel
    var body: some View {
        NavigationView {
            VStack {
                SearchBar().environmentObject(animeSearchViewModel)
                ZStack {
                    AnimeList
                    ProgressView()
                    .opacity(animeSearchViewModel.isLoading ? 1.0: 0.0)}
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
            //animeSearchViewModel.searchAnime(name: animeSearchViewModel.cache != nil ? animeSearchViewModel.cache! : "")
        }
    }
}

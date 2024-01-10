import SwiftUI

struct AnimeSearchView: View {
    @EnvironmentObject private var animeSearchViewModel: AnimeSearchViewModel
    var body: some View {
        NavigationView {
            VStack {
                SearchBar()
                    ZStack {
                        AnimeList
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationTitle("搜尋")
                            .refreshable {
                                    animeSearchViewModel.refreshCurrentList()
                            }
                            .onAppear() {
                                animeSearchViewModel.initTopAnimeList()
                            }
                            .navigationViewStyle(StackNavigationViewStyle())
                        ProgressView()
                            .opacity(animeSearchViewModel.isLoading ? 1.0: 0.0)
                    }
                }
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
            animeSearchViewModel.searchAnime(name: animeSearchViewModel.name)
        }
    }
}

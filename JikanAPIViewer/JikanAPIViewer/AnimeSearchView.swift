import SwiftUI

struct AnimeSearchView: View {
    @EnvironmentObject private var animeSearchViewModel: AnimeSearchViewModel
    @State var name: String
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $name)
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
        }.onAppear() {
            animeSearchViewModel.searchAnime(name: name)
       }
    }
}

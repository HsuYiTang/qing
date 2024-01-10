import SwiftUI

struct MainView: View {
    @StateObject var viewModel = TopAnimeViewModel()
    @StateObject var searchViewModel = AnimeSearchViewModel()
    
    var body: some View {
        TabView {
            TopAnimeView()
                .environmentObject(viewModel)
                .environmentObject(searchViewModel)
                .tabItem {
                    Label("Top Rank", systemImage: "list.number")
                }

            AnimeSearchView()
                .environmentObject(AnimeSearchViewModel)
                .tabItem {
                   Label("Favorite", systemImage: "heart")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

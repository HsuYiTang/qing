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

            AnimeSearchView(name: "")
                .environmentObject(searchViewModel)
                .tabItem {
                   Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

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
                    Label("排行榜", systemImage: "list.number")
                }

            AnimeSearchView()
                .environmentObject(searchViewModel)
                .tabItem {
                   Label("搜尋", systemImage: "magnifyingglass")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

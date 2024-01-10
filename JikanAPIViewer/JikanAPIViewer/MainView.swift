import SwiftUI

struct MainView: View {
    @StateObject var viewModel = TopAnimeViewModel()
    @StateObject var searchViewModel = AnimeSearchViewModel()
    @StateObject var randomAnimeViewModel = RandomAnimeViewModel()
    var body: some View {
        TabView {
            TopAnimeView()
                .onAppear(){
                    randomAnimeViewModel.initAnimeList()
                }
                .environmentObject(viewModel)
                .environmentObject(searchViewModel)
                .tabItem {
                    Label("排行榜", systemImage: "list.number")
                }
            RandomAnimeView()
                .environmentObject(randomAnimeViewModel)
                .tabItem{
                    Label("好手氣",systemImage:"lightbulb.circle")
                }
            AnimeSearchView()
                .onAppear(){
                    randomAnimeViewModel.initAnimeList()
                }
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

import Foundation
import SwiftUI

struct RandomAnimeView: View{
    @EnvironmentObject private var randomAnimeViewModel: RandomAnimeViewModel
    var body: some View{
        NavigationView {
            ZStack {
                AnimeDetailsView(item: randomAnimeViewModel.Anime)
                ProgressView()
                    .opacity(randomAnimeViewModel.isLoading ? 1.0: 0.0)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("")
            .refreshable {
                randomAnimeViewModel.refreshCurrentList()
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

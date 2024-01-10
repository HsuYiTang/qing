import Foundation

class RandomAnimeViewModel: ObservableObject{
    @Published var Anime: Anime?
    @Published var isLoading = false
    private var loadedAnimePage = 1
    private var APIService: JikanAPIServiceProtocol
    init(APIService: JikanAPIServiceProtocol = JikanAPIService()){
        self.APIService = APIService
    }
    
    func initAnimeList(){
        fetchRandomAnime()
    }
    
    private func fetchRandomAnime() {
        isLoading = true
        
        APIService.fetchRandomAnime(
                                 completionHandler: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    self.isLoading = false
                    if let randomAnime = response.data {
                        var existingList = self.Anime
                        existingList = randomAnime
                        self.Anime = existingList
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        })
    }
    
    func fetchNextAnimePage() {
        fetchRandomAnime()
    }
    
    func refreshCurrentList() {
        fetchRandomAnime()
    }
}

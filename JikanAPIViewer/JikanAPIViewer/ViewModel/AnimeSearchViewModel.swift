import Foundation

class AnimeSearchViewModel: ObservableObject {
    @Published var animeResult: [Anime] = [Anime]()
    @Published var isLoading = false
    private var name = ""
    private var APIService: JikanAPIServiceProtocol
    init(APIService: JikanAPIServiceProtocol = JikanAPIService()){
        self.APIService = APIService
    }
//    func initAnimeList(){
//        if animeResult.isEmpty {
//            fetchAnime(name: "")
//        }
//    }
    private func fetchAnime(name: String) {
        isLoading = true

        APIService.fetchAnime(name: name,
                                 completionHandler: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    self.isLoading = false
                    if let topList = response.data {
                        var existingList = self.animeResult
                        var newList = [Anime]()
                        
                        for anime in topList {
                            if !existingList.contains(anime) && anime.rank != nil {
                                newList.append(anime)
                            }
                        }
                        existingList.append(contentsOf: newList)
                        self.animeResult = existingList.sorted(by: { $0.rank! < $1.rank! })
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        })
    }
    
    func searchAnime(name: String) {
        fetchAnime(name: name)
    }
    
    func refreshCurrentList() {
        fetchAnime(name: name)
    }
}

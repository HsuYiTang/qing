//
//  TopAnimeViewModel.swift
//  JikanAPIViewer
//
//  Created by 徐翊棠 on 2024/1/4.
//

import Foundation

class TopAnimeViewModel: ObservableObject{
    @Published var topAnimeList: [Anime] = [Anime]()
    @Published var isLoading = false
    private var loadedAnimePage = 1
    private var APIService: JikanAPIServiceProtocol
    init(APIService: JikanAPIServiceProtocol = JikanAPIService()){
        self.APIService = APIService
    }
    func initTopAnimeList(){
        if topAnimeList.isEmpty {
            fetchTopAnime(page: 1)
        }
    }
    
    private func fetchTopAnime(page: Int) {
        isLoading = true
        
        APIService.fetchTopAnime(page: page,
                                 completionHandler: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    self.isLoading = false
                    if let topList = response.data {
                        var existingList = self.topAnimeList
                        var newList = [Anime]()
                        
                        for anime in topList {
                            if !existingList.contains(anime) {
                                newList.append(anime)
                            }
                        }
                        existingList.append(contentsOf: newList)
                        self.topAnimeList = existingList.sorted(by: { $0.rank ?? 0.0 < $1.rank ?? 0.0 })
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
        fetchTopAnime(page: loadedAnimePage + 1)
        loadedAnimePage += 1
    }
    
    func refreshCurrentList() {
        fetchTopAnime( page: loadedAnimePage)
    }
}

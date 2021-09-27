//
//  HomeViewModel.swift
//  Nerdflix
//
//  Created by Leonardo Cunha on 25/09/21.
//  Copyright © 2021 Leonardo Cunha. All rights reserved.
//

import Foundation
import Alamofire

class HomeViewModel {
    
    private var popularMovies: [MovieItemModel] = []
    private var tvShowMovies: [MovieItemModel] = []
    private var topMovies: [MovieItemModel] = []
    
    var updateLayout: (() -> Void)?
    var shouldShowErrorMessage: ((String) -> Void)?
    let arrayRequest: [String] = ["https://imdb-api.com/en/API/Top250Movies/k_l8tyyqy7"]
    
   // MARK: - Methods
    
    func getMoviesQuantity(index: Int) -> Int {
        if index == 0 {
            return popularMovies.count
        }
        if index == 1{
            return tvShowMovies.count
        }
        if index == 2{
            return topMovies.count
        }
        else{
            return 0
        }
    }
    func getMovieAt(index: Int, indexCollection: Int) -> MovieItemModel {
        if index == 0 {
            return popularMovies[indexCollection]
        }
        if index == 1{
            return tvShowMovies[indexCollection]
        }
        if index == 2{
            return topMovies[indexCollection]
        }
        else{
            return popularMovies[0]
        }
    }
    
    func getPopularMovies() {
            
            AF.request("https://imdb-api.com/en/API/MostPopularMovies/k_1ff4k2v8", method: .get).responseJSON{ (response) in
               // debugPrint("==> RESPONSE:", response)
                guard let data = response.data else {return}
                
                do {
                    let moviesModel = try JSONDecoder().decode(MoviesModel.self, from: data)
                    self.popularMovies = moviesModel.items ?? []
                    self.updateLayout?()
                    }catch(let error) {
                    self.shouldShowErrorMessage?(error.localizedDescription)
                    }
                }
            }
    func getTvShowMovies() {
        
            AF.request("https://imdb-api.com/en/API/Top250TVs/k_1ff4k2v8", method: .get).responseJSON{ (response) in
             //   debugPrint("==> RESPONSE:", response)
                guard let data = response.data else {return}
            
              do {
                    let tvShowModel = try JSONDecoder().decode(MoviesModel.self, from: data)
                    self.tvShowMovies = tvShowModel.items ?? []
                    self.updateLayout?()
                    }catch(let error) {
                        self.shouldShowErrorMessage?(error.localizedDescription)
                    }
                }
            }
    func getTopMovies() {
        
            AF.request("https://imdb-api.com/en/API/Top250Movies/k_1ff4k2v8", method: .get).responseJSON{ (response) in
            //    debugPrint("==> RESPONSE:", response)
                guard let data = response.data else {return}
            
                do {
                    let topMovies = try JSONDecoder().decode(MoviesModel.self, from: data)
                    self.topMovies = topMovies.items ?? []
                    self.updateLayout?()
                    }catch(let error) {
                        self.shouldShowErrorMessage?(error.localizedDescription)
                    }
            }
        }
        
    }

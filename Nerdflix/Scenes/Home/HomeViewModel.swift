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
    
    private var movies: [MovieItemModel] = []
    
    var updateLayout: (() -> Void)?
    var shouldShowErrorMessage: ((String) -> Void)?
    let arrayRequest: [String] = ["https://imdb-api.com/en/API/Top250Movies/k_l8tyyqy7"]
    
    func getMoviesQuantity() -> Int {
        movies.count
        
    }
    func getMovieAt(_ index: Int) -> MovieItemModel {
        return movies[index]
    }
    
    func getPopularMovies() {
        
        AF.request("https://imdb-api.com/en/API/Top250Movies/k_l8tyyqy7", method: .get).responseJSON{ (response) in
            debugPrint("==> RESPONSE:", response)
            guard let data = response.data else {return}
            
            do {
                let moviesModel = try JSONDecoder().decode(MoviesModel.self, from: data)
                self.movies = moviesModel.items ?? []
                self.updateLayout?()
                }catch(let error) {
                self.shouldShowErrorMessage?(error.localizedDescription)
                }
            }
            
            
        }
    func getMoviesList() {
        for index in 0...arrayRequest.count {
         
        AF.request(arrayRequest[index], method: .get).responseJSON{ (response) in
            debugPrint("==> RESPONSE:", response)
            guard let data = response.data else {return}
            
            do {
                let moviesModel = try JSONDecoder().decode(MoviesModel.self, from: data)
                self.movies = moviesModel.items ?? []
                self.updateLayout?()
                }catch(let error) {
                self.shouldShowErrorMessage?(error.localizedDescription)
                }
            }
        }
            
        }
        
        
    }
        


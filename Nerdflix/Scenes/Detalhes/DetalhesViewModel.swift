//
//  DetalhesViewModel.swift
//  Nerdflix
//
//  Created by Leonardo Cunha on 26/09/21.
//  Copyright © 2021 Leonardo Cunha. All rights reserved.
//

import Foundation
import Alamofire


class DetalhesViewModel {
    
    private var actorsModel: [ActorModel] = []
    
    var updateLayout: (() -> Void)?
    var shouldShowErrorMessage: ((String) -> Void)?
    
    func getMoviesDetails(_ id: String) {
        AF.request("https://imdb-api.com/en/API/FullCast/k_l8tyyqy7/\(id)", method: .get).responseJSON{ (response) in
        //    debugPrint("VER DETALHES: \(response)")
            guard let data = response.data else {return}
                
                do {
                    let details = try JSONDecoder().decode(DetailsModel.self, from: data)
                    self.actorsModel = details.actors ?? []
                    self.updateLayout?()
                    print(self.actorsModel)
                    }catch(let error) {
                    self.shouldShowErrorMessage?(error.localizedDescription)
                    }
                }
            }
    func getActorAt(_ index: Int) -> ActorModel? {
        return actorsModel[index]
        
    }
    func getActorsQuantity() -> Int{
        return actorsModel.count
    }
 
    
}
    
    
    


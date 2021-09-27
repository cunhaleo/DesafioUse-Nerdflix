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
        AF.request("https://imdb-api.com/en/API/FullCast/k_1ff4k2v8/\(id)", method: .get).responseJSON{ (response) in
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
 //   func getActorName(_ index: Int) -> String {
  //      return actorsModel[0].name ?? ""
        
  //  }
}
    
    
    


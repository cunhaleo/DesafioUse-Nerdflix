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
    
    func getMoviesDetails(_ id: String) {
        AF.request("https://imdb-api.com/en/API/FullCast/k_1ff4k2v8/\(id)", method: .get).responseJSON{ (response) in
            debugPrint("VER DETALHES: \(response)")

        }
    
    
    }
}

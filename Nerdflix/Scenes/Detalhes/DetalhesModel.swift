//
//  DetalhesModel.swift
//  Nerdflix
//
//  Created by Leonardo Cunha on 27/09/21.
//  Copyright © 2021 Leonardo Cunha. All rights reserved.
//

import Foundation

struct DetailsModel: Codable {
    
    let actors: [ActorModel]?
    
    
}


struct ActorModel: Codable {
    
    let name: String?
    let image: String?
    
    
    
}

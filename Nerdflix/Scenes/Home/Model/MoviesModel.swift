//
//  MoviesModel.swift
//  Nerdflix
//
//  Created by Leonardo Cunha on 25/09/21.
//  Copyright © 2021 Leonardo Cunha. All rights reserved.
//

import Foundation

struct MoviesModel: Codable {
    
    let items: [MovieItemModel]?
    
}

struct MovieItemModel: Codable {
    let fullTitle: String?
    let image: String?
    
    
    
    
}

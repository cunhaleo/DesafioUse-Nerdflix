//
//  MoviesCollectionViewCell.swift
//  Nerdflix
//
//  Created by Leonardo Cunha on 25/09/21.
//  Copyright © 2021 Leonardo Cunha. All rights reserved.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

    
    // MARK: - Outlets
    
    @IBOutlet weak var imageMovie: UIImageView!
    
    @IBOutlet weak var labelMovieTitle: UILabel!
    
    
    // MARK: - Ouverrides
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

}

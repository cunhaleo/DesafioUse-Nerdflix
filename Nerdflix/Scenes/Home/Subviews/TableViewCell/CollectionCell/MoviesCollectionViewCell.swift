//
//  MoviesCollectionViewCell.swift
//  Nerdflix
//
//  Created by Leonardo Cunha on 25/09/21.
//  Copyright © 2021 Leonardo Cunha. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesCollectionViewCell: UICollectionViewCell {

    
    // MARK: - Outlets
    
    @IBOutlet weak var imageMovie: UIImageView!
    
    @IBOutlet weak var labelMovieTitle: UILabel!
    
    
    // MARK: - Ouverrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
    
    }
    // MARK: - Methods
    
   func setupUI() {
        imageMovie.layer.cornerRadius = 8
        
    }
    
    func setupModel(_ movie: MovieItemModel?) {
        guard let movieModel = movie else {return}
        
        labelMovieTitle.text = movieModel.fullTitle
        
        guard let urlImage = movie?.image else {return}
        imageMovie.sd_setImage(with: URL(string: urlImage))
    }
    
}

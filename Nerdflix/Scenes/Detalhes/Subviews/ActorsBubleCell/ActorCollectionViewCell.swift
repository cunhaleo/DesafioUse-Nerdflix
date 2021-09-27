//
//  ActorCollectionViewCell.swift
//  Nerdflix
//
//  Created by Leonardo Cunha on 27/09/21.
//  Copyright © 2021 Leonardo Cunha. All rights reserved.
//

import UIKit

class ActorCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var imageActor: UIImageView!
    
    @IBOutlet weak var labelActorName: UILabel!
    
    
    
    //MARK: - Overrides

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    
    //MARK: - Methods
    func setupUI() {
        
        imageActor.layer.cornerRadius = 15
        
    }
    
    func setupModel(actor: ActorModel?) {
        guard let actorModel = actor else {return}
        
        labelActorName.text = actor?.name
        
        guard let urlImage = actor?.image else {return}
        imageActor.sd_setImage(with: URL(string: urlImage))
    }
}

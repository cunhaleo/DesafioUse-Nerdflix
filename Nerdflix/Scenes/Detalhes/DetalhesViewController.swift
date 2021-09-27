//
//  DetalhesViewController.swift
//  Nerdflix
//
//  Created by Leonardo Cunha on 26/09/21.
//  Copyright © 2021 Leonardo Cunha. All rights reserved.
//

import UIKit

class DetalhesViewController: UIViewController {

    private var viewModel: DetalhesViewModel = DetalhesViewModel()
    private var movieId: String = ""
        
        init(_ id: String) {
            super.init(nibName: nil, bundle: nil)
            self.movieId = id
            viewModel.getMoviesDetails(movieId)
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            title = "Detalhes"
        
        }
    
    }

//
//  VerMaisViewController.swift
//  Nerdflix
//
//  Created by Leonardo Cunha on 26/09/21.
//  Copyright © 2021 Leonardo Cunha. All rights reserved.
//

import UIKit

class VerMaisViewController: UIViewController {
    
    private var viewModel: HomeViewModel = HomeViewModel()
    
    let arrayCategory : [String] = ["Filmes mais premiados", "Séries de TV", "Filmes populares" ]
    
    var category: Int = 0
    
    @IBOutlet weak var labelCategory: UILabel!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    init(category: Int) {
        super.init(nibName: nil, bundle: nil)
        self.category = category
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ver Mais"
        setupUI()
        bindEvents()
        if category == 0 {
            viewModel.getPopularMovies()
        }
        if category == 1 {
            viewModel.getTvShowMovies()
        }
        else {
            viewModel.getTopMovies()
        }
        setupCollectioView()
        

    }
    func setupUI() {
        labelCategory.text = arrayCategory[self.category]
          
    }
    func bindEvents() {
        viewModel.updateLayout = { [weak self] in
            DispatchQueue.main.async {
                self?.moviesCollectionView.reloadData()
            }
        }
    }
    func setupCollectioView() {
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        moviesCollectionView.setCollectionViewLayout(layout, animated: true)
        moviesCollectionView.register(UINib(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        
    }
    func showMovieDetails(_ id: String?) {
        guard let idValue = id else {return}
        let controller = DetalhesViewController(idValue)
        navigationController?.pushViewController(controller, animated: true)
        
    }
}
extension VerMaisViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let item = viewModel.getMovieAt(index: self.category, indexCollection: indexPath.item)
    let movieId = item.id
    showMovieDetails(movieId)
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 15
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (UIScreen.main.bounds.width/2)-40, height: 250)
}


func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.getMoviesQuantity(index: self.category)
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let item = viewModel.getMovieAt(index: self.category, indexCollection: indexPath.item)
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as? MoviesCollectionViewCell else {
        return UICollectionViewCell.init(frame: .zero)
    }
    cell.setupModel(item)
    return cell
}
}

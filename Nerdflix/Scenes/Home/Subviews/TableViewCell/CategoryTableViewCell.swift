//
//  CategoryTableViewCell.swift
//  Nerdflix
//
//  Created by Leonardo Cunha on 25/09/21.
//  Copyright © 2021 Leonardo Cunha. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    
    //MARK: - Attributes & Variables
    
    
    private var viewModel: HomeViewModel = HomeViewModel()
    
    // MARK: - Outlets
    
    @IBOutlet weak var labelCategoria: UILabel!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    // MARK : - Overrides

    override func awakeFromNib() {
        super.awakeFromNib()
        bindEvents()
        viewModel.getPopularMovies()
       // viewModel.getMoviesList()
        setupCollectionView()

        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    // MARK: - Methods
    
    private func showMovieDetails(_ id: String?) {
         guard let idValue = id else {return}
         let controller = DetalhesViewController(idValue)
         //navigationController?.pushViewController(controller, animated: true)
    }
    
    func bindEvents() {
    viewModel.updateLayout = { [weak self] in
            DispatchQueue.main.async {
                print("TRATOU O MODEL NO CATEGORY")                                             // COMMENTARIOS
                print("getMovies:", self?.viewModel.getMoviesQuantity())
                self?.moviesCollectionView.reloadData()
            }
        
        }
   }

    func setupCell(categoria: String){ // Label categoria e botão ver mais
        labelCategoria.text = categoria
        
        
    }
    func setupCollectionView() {
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        //layout.itemSize = CGSize(width: 200, height: 300)
        moviesCollectionView.setCollectionViewLayout(layout, animated: true)
        moviesCollectionView.register(UINib(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        
        
    }
}
extension CategoryTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.getMovieAt(indexPath.item)
        let movieId = item.id
        showMovieDetails(movieId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width/2)-40, height: 250)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getMoviesQuantity()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.getMovieAt(indexPath.item)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as? MoviesCollectionViewCell else {
            return UICollectionViewCell.init(frame: .zero)
        }
        cell.setupModel(item)
        return cell
    }
}

//
//  CategoryTableViewCell.swift
//  Nerdflix
//
//  Created by Leonardo Cunha on 25/09/21.
//  Copyright © 2021 Leonardo Cunha. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell, UINavigationControllerDelegate {
    
    
    
    
    //MARK: - Attributes & Variables
    
    
    private var viewModel: HomeViewModel = HomeViewModel()
    private var index: Int = 0
    // MARK: - Outlets & Actions
    
    @IBAction func buttonVerMais(_ sender: Any) {
        verMais()
    }
    @IBOutlet weak var labelCategoria: UILabel!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    
    
    // MARK : - Overrides

    override func awakeFromNib() {
        super.awakeFromNib()
        bindEvents()
        viewModel.getPopularMovies()
        viewModel.getTvShowMovies()
        viewModel.getTopMovies()
        setupCollectionView()
    }
    
    // MARK: - Methods
    
    private func verMais() {
        let controller = VerMaisViewController(category: index) // adicionar categoria como parametro
        parentViewController?.navigationController?.pushViewController(controller, animated: true)
    }
    private func showMovieDetails(_ id: String?) {
         guard let idValue = id else {return}
         let controller = DetalhesViewController(idValue)
        parentViewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func bindEvents() {
    viewModel.updateLayout = { [weak self] in
            DispatchQueue.main.async {
                self?.moviesCollectionView.reloadData()
            }
        
        }
   }

    func setupCell(categoria: String, index: Int){
        labelCategoria.text = categoria
        self.index = index
        
        
    }
    func setupCollectionView() {
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        moviesCollectionView.setCollectionViewLayout(layout, animated: true)
        moviesCollectionView.register(UINib(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        
        
    }
}
extension CategoryTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.getMovieAt(index: self.index, indexCollection: indexPath.item)
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
        return viewModel.getMoviesQuantity(index: self.index)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.getMovieAt(index: self.index, indexCollection: indexPath.item)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as? MoviesCollectionViewCell else {
            return UICollectionViewCell.init(frame: .zero)
        }
        cell.setupModel(item)
        return cell
    }
}
extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

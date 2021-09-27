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
    
    // MARK: - Outlets
    
    @IBOutlet weak var actorsCollectionView: UICollectionView!
    
    
    
    // MARK: - Overrides
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
            bindEvents()
            viewModel.getMoviesDetails(movieId)
            setupUI()
            setupCollectionView()
        
        }
    func setupUI() {
        title = "Detalhes"
        
        
    }
    func setupCollectionView() {
        actorsCollectionView.delegate = self
        actorsCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        actorsCollectionView.setCollectionViewLayout(layout, animated: true)
        actorsCollectionView.register(UINib(nibName: "ActorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ActorCollectionViewCell")
        actorsCollectionView.reloadData()
    }

    
    
    func bindEvents() {
    viewModel.updateLayout = { [weak self] in
            DispatchQueue.main.async {
                self?.actorsCollectionView.reloadData()
            }
        }
    }
}
extension DetalhesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 20
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (UIScreen.main.bounds.width/3), height: (UIScreen.main.bounds.width/3))
        }
        

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return viewModel.getActorsQuantity()
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let actor = viewModel.getActorAt(indexPath.item)
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorCollectionViewCell", for: indexPath) as? ActorCollectionViewCell else {
                return UICollectionViewCell.init(frame: .zero)
            }
            cell.setupModel(actor: actor)
            return cell
        }
}



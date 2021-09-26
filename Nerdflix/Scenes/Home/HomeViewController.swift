//
//  HomeViewController.swift
//  Nerdflix
//
//  Created by Leonardo Cunha on 25/09/21.
//  Copyright © 2021 Leonardo Cunha. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate{
   
    
    
    // MARK: - Variables & Attributes
    
    private var viewModel: HomeViewModel = HomeViewModel()
    
    var arrayCategory : [String] = ["Para você", "Filmes mais vistos", "Filmes premiados" ]
    

    

    //MARK: - Outlets
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    // MARK:  - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        setupUI()

    }
    
    func setupUI() {
        
        title = "Nerdflix"
        navigationController?.navigationBar.barTintColor = UIColor(red: 58.0/255.0, green: 58.0/255.0, blue: 58.0/255.0, alpha: 1)
        navigationController?.navigationBar.barStyle = UIBarStyle.blackOpaque
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        tableView.reloadData()

    }
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayCategory.count
    }
          
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as? CategoryTableViewCell {
            cell.setupCell(categoria: arrayCategory[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
        
        
        
        
}


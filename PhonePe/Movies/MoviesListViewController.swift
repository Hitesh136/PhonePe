//
//  MoviesListViewController.swift
//  PhonePe
//
//  Created by Hitesh Agarwal on 10/09/22.
//

import UIKit

class MoviesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.dataSource = self
            tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        }
    }
    var viewModel: MovieListViewModel!
    
    static func getInstance(viewModel: MovieListViewModel) -> MoviesListViewController {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let viewController = main.instantiateViewController(withIdentifier: "MoviesListViewController") as! MoviesListViewController
        viewController.viewModel = viewModel
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieData()
    }
    
    func getMovieData() {
        viewModel.getMovies { [weak self] errorMessage in
            guard let self = self else { return }
            if let errorMessage = errorMessage {
                // We can show a alert message here
                print(errorMessage)
                return
            }
            
            self.tableView.reloadData()
        }
    }
    

    @IBAction func actionFilter(_ sender: Any) {
        
    }

}

extension MoviesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        cell.configure(cellViewModel: viewModel.cellViewModel(atIndexPath: indexPath), indexPath: indexPath, delegate: self)
        return cell
    }
    
}


extension MoviesListViewController: MovieTableViewCellDelegate {
    func actionAddInPlayList(atIndexPath indexPath: IndexPath, cellViewModel: MovieTableCellViewModel) {
        
    }
}

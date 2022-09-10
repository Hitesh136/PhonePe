//
//  PlayListViewController.swift
//  PhonePe
//
//  Created by Hitesh Agarwal on 10/09/22.
//

import UIKit

protocol PlayListViewControllerDelegate: AnyObject {
    func reloadView()
}

class PlayListViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: "PlayListTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayListTableViewCell")
        }
    }
    
    // MARK: - Variables
    var viewModel: PlayListViewModel!
    var keyValueObservation: NSKeyValueObservation!
    weak var delegate: PlayListViewControllerDelegate?
    
    static func getInstance(viewModel: PlayListViewModel) -> PlayListViewController {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let viewController = main.instantiateViewController(withIdentifier: "PlayListViewController") as! PlayListViewController
        viewController.viewModel = viewModel
        return viewController
    }
    
    // MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Configurations
    func configureView() {
        self.viewModel.fetchItemsFromDB()
        self.tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        tableView.reloadData()
    }
    
    // MARK: - Helper Methods
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        
         if(keyPath == "contentSize") {
             if let newvalue = change?[.newKey] {
                 DispatchQueue.main.async {
                     let newsize  = newvalue as! CGSize
                     self.tableViewHeightConstraint.constant = newsize.height
                 }
             }
         }
     }
    
    // MARK: - IBActions
    @IBAction func actionDismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionCreatePlayList(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Create New Playlist",
                                                message: nil,
                                                preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "PlayList Name"
        }
        
        
        
        let continueAction = UIAlertAction(title: "Done",
                                           style: .default) { [weak alertController] _ in
            guard let textFields = alertController?.textFields else { return }
            
            if let playListName = textFields[0].text {
                self.viewModel.createNewPlayList(withName: playListName)
                self.viewModel.fetchItemsFromDB()
                
                self.tableView.reloadData()
                
            }
        }
        alertController.addAction(continueAction)
        
        self.present(alertController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension PlayListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayListTableViewCell") as! PlayListTableViewCell
        cell.configure(withViewModel: viewModel.cellViewModel(atIndexPath: indexPath))
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PlayListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.addMovie(atIndexPath: indexPath)
        self.delegate?.reloadView()
        dismiss(animated: true, completion: nil)
    }
}

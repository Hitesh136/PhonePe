//
//  ContentTableViewCell.swift
//  Caraousell
//
//  Created by Hitesh Agarwal on 10/09/22.
//

import UIKit
import SDWebImage

protocol MovieTableViewCellDelegate: AnyObject {
    func actionAddInPlayList(atIndexPath indexPath: IndexPath, cellViewModel: MovieTableCellViewModel)
}

class MovieTableViewCell: UITableViewCell {
 
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var moviePlaylistLabel: UILabel!
    
    
    var viewModel: MovieTableCellViewModel!
    var cellIndexPath: IndexPath!
    weak var delegate: MovieTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func actionStart(_ sender: Any) {
        
    }
    
    func configure(cellViewModel: MovieTableCellViewModel,
                   indexPath: IndexPath,
                   delegate: MovieTableViewCellDelegate) {
        self.viewModel = cellViewModel
        self.cellIndexPath = indexPath
        self.delegate = delegate
        
        
        movieRatingLabel.text = viewModel.rating
        movieTitleLabel.text = viewModel.movieName
        moviePlaylistLabel.text = viewModel.playList
        movieImageView.sd_setImage(with: viewModel.movieImageURL)
    }
      
}

//
//  PlayListTableViewCell.swift
//  PhonePe
//
//  Created by Hitesh Agarwal on 10/09/22.
//

import UIKit

class PlayListTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var playListNameLabel: UILabel!
    
    // MARK: - View Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Configuration Methods
    func configure(withViewModel: PlayItemViewModel) {
        playListNameLabel.text = withViewModel.name
    }
}

//
//  PlayListCellViewModel.swift
//  PhonePe
//
//  Created by Hitesh Agarwal on 10/09/22.
//

import Foundation

class PlayItemViewModel {
    var dto: PlaylistDTO
    var name: String
    init(dto: PlaylistDTO) {
        self.dto = dto
        self.name = dto.name
    }
}

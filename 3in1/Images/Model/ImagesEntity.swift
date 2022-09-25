//
//  ImagesEntity.swift
//  3in1
//
//  Created by Medet Dönmez on 22.09.2022.
//

import Foundation
import UIKit

struct ImagesCellViewModel {
    
    var imageUrl: String?
}


struct ImagePost: Decodable {
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
}

//
//  PostListEntity.swift
//  3in1
//
//  Created by Medet Dönmez on 22.09.2022.
//

import Foundation

struct PostsCellViewModel {
    
    var title: String?
    var desc: String?
}

struct Post: Decodable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}


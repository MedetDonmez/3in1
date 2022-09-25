//
//  ImagesViewModel.swift
//  3in1
//
//  Created by Medet Dönmez on 22.09.2022.
//

import Foundation
import Kingfisher
import UIKit

protocol ImagesViewModelProtocol: AnyObject {
    
    func didCellItemFetch(_ items: [ImagesCellViewModel])
}

class ImagesViewModel {
    
    weak var viewDelegate: ImagesViewModelProtocol?
    
    let model = ImagesModel()
    
    init() {
        model.delegate = self
    }
    
    func didViewLoad() {
        model.fetchData()
    }
    
}

private extension ImagesViewModel {
    
    @discardableResult
    func makeViewBasedModel(_ posts: [ImagePost]) -> [ImagesCellViewModel] {
        
        return posts.map {.init(imageUrl: $0.url)
        }
    }
}

extension ImagesViewModel: ImagesModelProtocol {

    
    func didDataFetch(_ isSuccess: Bool) {
        if isSuccess {
            
            let posts = model.posts
            let cellModels = makeViewBasedModel(posts)
            viewDelegate?.didCellItemFetch(cellModels)
            
        } else {
            print("Can't fetch data.")
        }
    }
}

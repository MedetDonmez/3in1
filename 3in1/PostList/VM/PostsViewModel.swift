//
//  PostListViewModel.swift
//  3in1
//
//  Created by Medet Dönmez on 22.09.2022.
//

import Foundation

protocol PostsViewModelViewProtocol: AnyObject {
    
    func didCellItemFetch(_ items: [PostsCellViewModel])
}

class PostsViewModel {
    
    weak var viewDelegate: PostsViewModelViewProtocol?
    
    let model = PostsModel()
    
    init() {
        model.delegate = self
    }
    
    func didViewLoad() {
        model.fetchData()
    }

}

private extension PostsViewModel {
    
    @discardableResult
    func makeViewBasedModel(_ posts: [Post]) -> [PostsCellViewModel] {
        return posts.map {.init(title: $0.title, desc: $0.body )
        }
    }
}

extension PostsViewModel: PostsModelProtocol {
    
    func didDataFetch(_ isSuccess: Bool) {
        if isSuccess {
            let posts = model.posts
            let cellModels = makeViewBasedModel(posts)
            viewDelegate?.didCellItemFetch(cellModels)

            
        } else {
            print("Data couldn't fetch")
            
        }
        

    }
}

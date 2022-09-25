//
//  PostListModel.swift
//  3in1
//
//  Created by Medet Dönmez on 22.09.2022.
//

import Foundation

protocol PostsModelProtocol: AnyObject {
    func didDataFetch(_ isSuccess: Bool)
}

class PostsModel {
    weak var delegate: PostsModelProtocol?
    
    var posts: [Post] = []

    func fetchData() {
        
        guard let url = URL.init(string: "https://jsonplaceholder.typicode.com/posts") else {
            delegate?.didDataFetch(false)
            return
        }
        var request: URLRequest = .init(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                error == nil
            else {
                self.delegate?.didDataFetch(false)
                return
            }
            guard let data = data else {
                self.delegate?.didDataFetch(false)
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                self.posts = try jsonDecoder.decode([Post].self, from: data)
                self.delegate?.didDataFetch(true)
                
            } catch {
                self.delegate?.didDataFetch(false)
            }
            
        }
        
        
        
        task.resume()
}
}

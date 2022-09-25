//
//  ImagesModel.swift
//  3in1
//
//  Created by Medet Dönmez on 22.09.2022.
//

import Foundation

protocol ImagesModelProtocol: AnyObject {
    func didDataFetch(_ isSuccess: Bool)
}

class ImagesModel {
    weak var delegate : ImagesModelProtocol?
    
    var posts: [ImagePost] = []
    
    func fetchData() {
        guard let url = URL.init(string: "https://jsonplaceholder.typicode.com/photos") else {
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
                self.posts = try jsonDecoder.decode([ImagePost].self, from: data)
                self.delegate?.didDataFetch(true)
                
            } catch {
                
                self.delegate?.didDataFetch(false)
            }
            
        }
        
        
        
        task.resume()
    }
}

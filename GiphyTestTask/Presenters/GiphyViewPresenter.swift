//
//  MainViewPresenter.swift
//  GiphyTestTask
//
//  Created by Dan on 21.10.2019.
//  Copyright © 2019 Daniil. All rights reserved.
//

import UIKit

class GiphyViewPresenter {

    let cellId = "iamgeCell"
    
    private let dataService: DataService
    private let imageDownloadService: ImageDonwloadService
    
    init(dataService: DataService, imageDownloadService: ImageDonwloadService) {
        self.dataService = dataService
        self.imageDownloadService = imageDownloadService
    }
    
    
    ///Передаем значения в замыкании
    func getGifs(completion: @escaping ((_ gifs: [ImagesData]?, _ error: Error?) -> ())) {
        
        let parameters = ["api_key" : "QYPYGjvLtY7Ib7kJk2nLfNl5q9080p8q",
                          "limit" : "5"]
        
        dataService.request(path: .trending,
                            parameters: parameters) { (gif: GiphyImage?, error: Error?) in
                                
            if let gif = gif {
                if let data = gif.data {
                    completion(data, nil)
                }
            } else {
                completion(nil, error)
            }
        }
    }
    
    ///Передаем значения в замыкании
    func downloadImages(with urlString: String,
                        completion: @escaping ((_ image: UIImage?) -> ())) {
        
        if let url = URL(string: urlString) {
            imageDownloadService.getImage(withURL: url) { (image) in
                if let image = image {
                    completion(image)
                }
            }
        }
    }
}

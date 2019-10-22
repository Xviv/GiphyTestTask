//
//  ImageDownloadService.swift
//  GiphyTestTask
//
//  Created by Dan on 22.10.2019.
//  Copyright © 2019 Daniil. All rights reserved.
//

import UIKit

class ImageDonwloadService {
    
    private let cache = NSCache<NSString, UIImage>()
    
    private func downloadImage(withURL url: URL, completion: @escaping (_ image: UIImage?) ->()) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            var downloadedImage: UIImage?
            
            if let data = data {
                downloadedImage = UIImage(data: data)
            }
            ///Сохраняем в кэш
            if downloadedImage != nil {
                self.cache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
            }
            
            DispatchQueue.main.async {
                completion(downloadedImage)
            }
        }
        
        dataTask.resume()
    }
    
    func getImage(withURL url: URL, completion: @escaping (_ image: UIImage?) ->()) {
        ///Проверяем на наличие в кэше, если есть – берем от туда, если нет – загружаем
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            completion(image)
        } else {
            downloadImage(withURL: url, completion: completion)
        }
    }

}

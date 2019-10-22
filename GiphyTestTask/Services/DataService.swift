//
//  JSONService.swift
//  GiphyTestTask
//
//  Created by Dan on 22.10.2019.
//  Copyright © 2019 Daniil. All rights reserved.
//

import Foundation

enum Path {
    ///Можно написать больше кейсов, но так как я работаю с одним, мне хватит
    case trending
}

struct DataService {
    ///Запрос на загрузку ссылок картонок
    func request<T: Codable>(path: Path,
                             parameters: [String: String],
                             handler: @escaping (T?, _ error: Error?)->()) {
        
        ///Создание запроса с параметрами
        var components = URLComponents()
        components.scheme = "http"
        components.host = "api.giphy.com"
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        switch path {
        case .trending:
            components.path = "/v1/gifs/trending"
        }
        
        ///Эпл рекомендует добавлять эту строчку
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        let request = URLRequest(url: components.url!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let decoder = JSONDecoder()
            if let data = data {
                ///Декодируем и отправляем объект типа T: Codable
                let result = try! decoder.decode(T.self, from: data)
                handler(result, nil)
            } else {
                handler(nil, error)
            }
        }.resume()
    }
}

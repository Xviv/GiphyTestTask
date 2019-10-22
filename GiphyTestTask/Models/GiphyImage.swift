//
//  GiphyImage.swift
//  GiphyTestTask
//
//  Created by Dan on 21.10.2019.
//  Copyright © 2019 Daniil. All rights reserved.
//

import Foundation


struct GiphyImage: Codable {
    var data: [ImagesData]?
}

struct ImagesData: Codable {
    var images: Original?
}

struct Original: Codable {
    var original: Image?
}

struct Image: Codable {
    var url: String?
}

//
//  CollectionViewCell.swift
//  GiphyTestTask
//
//  Created by Dan on 21.10.2019.
//  Copyright © 2019 Daniil. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///Создание и настройка объекта UIImageView
    let gifImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    ///Настройка ограничений для UIImage
    func setupViews() {
        addSubview(gifImage)
        
        gifImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        gifImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        gifImage.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
        gifImage.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -10).isActive = true
    }
}

    ///Возвращает имя строкой, удобно когда работаешь с большим числом разных viewCell
extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self.self)
    }
}

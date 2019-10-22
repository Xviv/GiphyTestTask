//
//  GiphyViewControllerDataSource.swift
//  GiphyTestTask
//
//  Created by Dan on 21.10.2019.
//  Copyright © 2019 Daniil. All rights reserved.
//

import UIKit

extension GiphyFeedViewController: UICollectionViewDelegateFlowLayout {
    //MARK: DataSource
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        ///Объявляем переиспользуемую ячейку
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
        
        if let imageUrl = gifs[indexPath.row].images?.original?.url {
            ///Загружаем картинки
            presenter?.downloadImages(with: imageUrl, completion: { (image) in
                imageCell.gifImage.image = image
            })
        }
        
        return imageCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifs.count
    }
    
    //MARK: FlowLayoutDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        ///Убираем боковое расстояние между ячейками
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        ///Убираем расстояние между ячейками сверху и снизу
        return 0.0
    }
    
}

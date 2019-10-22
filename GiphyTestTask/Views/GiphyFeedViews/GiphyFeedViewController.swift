//
//  ViewController.swift
//  GiphyTestTask
//
//  Created by Dan on 21.10.2019.
//  Copyright © 2019 Daniil. All rights reserved.
//

import UIKit

class GiphyFeedViewController: UICollectionViewController {
    
    //MARK: - Vars/consts
    
    var presenter: GiphyViewPresenter?
    var refreshControl = UIRefreshControl()
    var gifs: [ImagesData] = []
    
    //MARK: - Initialization
    
    init(with presenter: GiphyViewPresenter, flowLayout: UICollectionViewFlowLayout) {
        self.presenter = presenter
        super.init(collectionViewLayout: flowLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ViewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interfaceSetup()
        buttonAndLabelSetup()
        refreshControlSetup()
    }
    
    private func gifsFetch() {
        presenter?.getGifs(completion: { (gifs, error) in
            if let gifs = gifs {
                self.gifs = gifs
                DispatchQueue.main.async {
                    /// Изменение интерфейса в зависимости от того, что мы получили от презентреа
                    self.updateUI(alpha: 0)
                }
            } else {
                guard let error = error else { return }
                DispatchQueue.main.async {
                    /// Изменение интерфейса в зависимости от того, что мы получили от презентреа
                    self.gifs = []
                    self.errorLabel.text = error.localizedDescription
                    self.updateUI(alpha: 1)
                }
            }
        })
    }
    
    ///Штука которая крутится, когда тянешь экран вниз
    func refreshControlSetup() {
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        collectionView.addSubview(refreshControl)
        collectionView.alwaysBounceVertical = true
    }
    
    //MARK: - Interface setup
    
    let refreshButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(r: 55, g: 87, b: 219)
        button.setTitle("RELOAD PAGE", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
        button.alpha = 0
        
        return button
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "test"
        label.textAlignment = .center
        label.numberOfLines = 3
        label.alpha = 0
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private func interfaceSetup() {
        title = "GIPHY"
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.backgroundColor = .white
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        gifsFetch()
    }
    
    private func updateUI(alpha: CGFloat) {
        self.refreshButton.alpha = alpha
        self.errorLabel.alpha = alpha
        self.collectionView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    private func buttonAndLabelSetup() {
        view.addSubview(refreshButton)
        view.addSubview(errorLabel)
        
        refreshButton.centerXAnchor.constraint(equalTo: self.collectionView.centerXAnchor).isActive = true
        refreshButton.centerYAnchor.constraint(equalTo: self.collectionView.centerYAnchor, constant: self.view.frame.height / 8).isActive = true
        refreshButton.widthAnchor.constraint(equalToConstant: self.collectionView.frame.width / 2).isActive = true
        refreshButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        errorLabel.centerXAnchor.constraint(equalTo: self.collectionView.centerXAnchor).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: self.collectionView.centerYAnchor, constant: 20).isActive = true
        errorLabel.widthAnchor.constraint(equalTo: self.collectionView.widthAnchor, constant: -60).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    //MARK: - Actions
    
    @objc func refreshButtonTapped() {
        gifsFetch()
    }
    
    @objc func refresh(sender:AnyObject) {
        gifsFetch()
    }
    
}

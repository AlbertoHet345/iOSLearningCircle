//
//  CollectionViewController.swift
//  iOSLearningCircle
//
//  Created by Alberto Garcia on 12/07/23.
//

import UIKit
import SDWebImage

class CollectionViewController: UICollectionViewController {
    let myArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    private var pokemons: [Pokemon] = []
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokedex()
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
    }
    
    
    
    private func fetchPokedex() {
        Task {
            let pokemons = try await HTTPClient.loadPokedex()
            self.pokemons = pokemons
            collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension CollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pokemons.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath) as! CustomCell
        cell.configure(pokemon: pokemons[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension CollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemRed
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (view.frame.width / 2) - 16, height: (view.frame.height / 6) - 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        16
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
}

class CustomCell: UICollectionViewCell {
    
    let label: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 16)
        lb.textColor = .white
        lb.text = "1"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "plus.square.fill")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func configure(pokemon: Pokemon) {
        imageView.sd_setImage(with: URL(string: pokemon.imageUrl))
        if pokemon.type == "poison" {
            backgroundColor = .systemGreen
        } else if pokemon.type == "fire" {
            backgroundColor = .systemRed
        } else if pokemon.type == "water" {
            backgroundColor = .systemBlue
        } else {
            backgroundColor = .white
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

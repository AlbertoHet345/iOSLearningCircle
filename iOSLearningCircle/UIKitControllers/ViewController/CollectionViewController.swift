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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Pokédex"
        navigationController?.navigationBar.prefersLargeTitles = true
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
        CGSize(width: (view.frame.width / 2) - 32, height: (view.frame.height / 6) - 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        16
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
}

class CustomCell: UICollectionViewCell {
    
    let label: UILabel = {
        let lb = UILabel()
        lb.font = .boldSystemFont(ofSize: 16)
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
        
        layer.cornerRadius = 25
        
        addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        addSubview(label)
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
    }
    
    func configure(pokemon: Pokemon) {
        label.text = "#\(pokemon.id)"
        imageView.sd_setImage(with: URL(string: pokemon.imageUrl))
        backgroundColor = pokemon.type.color
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  CollectionViewController.swift
//  iOSLearningCircle
//
//  Created by Alberto Garcia on 12/07/23.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    let myArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        myArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath) as! CustomCell
        cell.label.text = "\(myArray[indexPath.item])"
        return cell
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
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .systemBlue
        
        addSubview(label)
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

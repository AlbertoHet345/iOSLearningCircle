//
//  CompanyCell.swift
//  iOSLearningCircle
//
//  Created by Alberto Garcia on 09/05/23.
//

import UIKit

class CompanyCell: UITableViewCell {

    @IBOutlet weak var companyImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    
    func configure(company: Company) {
        if let name = company.name, let founded = company.founded {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            
            let foundedString = dateFormatter.string(from: founded)
            
            companyNameLabel.text = "\(name) - Founded: \(foundedString)"
        } else {
            companyNameLabel.text = company.name
        }
//        companyImageView.image = UIImage(systemName: "person.crop.circle.dashed")
        
        if let imageData = company.imageData {
            companyImageView.image = UIImage(data: imageData)
        } else {
            companyImageView.image = UIImage(systemName: "person.crop.circle.dashed")
        }
        companyImageView.layer.cornerRadius = companyImageView.frame.width / 2
        companyImageView.clipsToBounds = true
        companyImageView.layer.borderColor = UIColor.black.cgColor
        companyImageView.layer.borderWidth = 2
//        companyImageView.image = UIImage(named: company.image)
    }
}

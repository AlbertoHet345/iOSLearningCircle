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
        
        if let imageData = company.imageData {
            companyImageView.image = UIImage(data: imageData)
            companyImageView.setCircularImageView()
        } else {
            companyImageView.image = UIImage(systemName: "person.crop.circle.dashed")
        }

    }
}

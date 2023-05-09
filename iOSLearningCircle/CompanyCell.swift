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
        companyNameLabel.text = company.name
        companyImageView.image = UIImage(systemName: "person.crop.circle.dashed")
    }
}

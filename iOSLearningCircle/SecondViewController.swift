//
//  SecondViewController.swift
//  iOSLearningCircle
//
//  Created by Alberto Garcia on 25/04/23.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var companyImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var founderLabel: UILabel!
    @IBOutlet weak var foundationYearLabel: UILabel!
    var company: Company?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let company = company else { return }
        companyImageView.image = UIImage(named: company.image)
        companyNameLabel.text = company.name
        founderLabel.text = "Founder: \(company.founder)"
        foundationYearLabel.text = "Foundation year: \(company.foundationYear)"
    }

}

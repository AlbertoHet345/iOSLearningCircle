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
    @IBOutlet weak var founderTextField: UITextField!
    @IBOutlet weak var foundationYearTextField: UITextField!
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
        founderTextField.text = "Founder: \(company.founder)"
        foundationYearTextField.text = "Foundation year: \(company.foundationYear)"
    }

}

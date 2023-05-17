//
//  SecondViewController.swift
//  iOSLearningCircle
//
//  Created by Alberto Garcia on 25/04/23.
//

import UIKit

protocol CreateCompanyDelegate: AnyObject {
    func createCompanyController(_ createCompanyController: CreateCompanyController, didCreateCompany company: Company)
}

class CreateCompanyController: UIViewController {
    
    weak var delegate: CreateCompanyDelegate?

    @IBOutlet weak var companyImageView: UIImageView!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var founderTextField: UITextField!
    @IBOutlet weak var foundationYearTextField: UITextField!
    @IBOutlet weak var selectImageButton: UIButton!
    var company: Company?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Create"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .save,
                                                            primaryAction: UIAction.init(handler: { [weak self] _ in
            guard let self = self else { return }
            self.didTapSave()
        }))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let company = company else {
            companyImageView.image = UIImage(systemName: "person.crop.circle.dashed")
            return
        }
        companyImageView.image = UIImage(named: company.image)
        companyNameTextField.text = company.name
        founderTextField.text = "Founder: \(company.founder)"
        foundationYearTextField.text = "Foundation year: \(company.foundationYear)"
        
    }
    @IBAction func didTapSelectImage(_ sender: Any) {
        let alertController = UIAlertController(title: "Choose a photo", message: "Select a picture from library or camera", preferredStyle: .actionSheet)
        
        let libraryAction = UIAlertAction(title: "Library", style: .default) { [weak self] _ in
            guard let self = self else { return }
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            self.present(imagePicker, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(libraryAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    private func didTapSave() {
        guard let name = companyNameTextField.text,
              let founder = founderTextField.text,
              let foundationYearString = foundationYearTextField.text,
              let foundationYear = Int(foundationYearString) else { return }
        let companyCreated = Company(name: name,
                                     foundationYear: foundationYear,
                                     founder: founder,
                                     image: "person.crop.circle.dashed")
        delegate?.createCompanyController(self, didCreateCompany: companyCreated)
        dismiss(animated: true)
    }

}

extension CreateCompanyController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        companyImageView.image = image
        dismiss(animated: true)
    }
}

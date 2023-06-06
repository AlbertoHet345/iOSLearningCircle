//
//  SecondViewController.swift
//  iOSLearningCircle
//
//  Created by Alberto Garcia on 25/04/23.
//

import UIKit
import CoreData

enum CreateCompanyControllerState {
    case add
    case edit
    case detail
}

protocol CreateCompanyDelegate: AnyObject {
    func createCompanyController(_ createCompanyController: CreateCompanyController, didCreateCompany company: Company)
    func createCompanyController(_ createCompanyController: CreateCompanyController, didEditCompany company: Company)
}

class CreateCompanyController: UIViewController {
    
    weak var delegate: CreateCompanyDelegate?

    @IBOutlet weak var companyImageView: UIImageView!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var founderTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var selectImageButton: UIButton!
    var company: Company?
    var state: CreateCompanyControllerState = .edit
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
        
        switch state {
        case .add:
            navigationItem.title = "Create Company"
            setSaveButton()
        case .edit:
            navigationItem.title = "Edit Company"
            setSaveButton()
        case .detail:
            navigationItem.title = "Company"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setSaveButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .save,
                                                            primaryAction: UIAction.init(handler: { [weak self] _ in
            guard let self = self else { return }
            self.didTapSave()
        }))
    }
    
    private func setupUI() {
        switch state {
        case .add, .edit:
            selectImageButton.isHidden = false
        case .detail:
            selectImageButton.isHidden = true
        }
        
        guard let company = company else {
            return
        }

        companyNameTextField.text = company.name
        if let founded = company.founded {
            datePicker.date = founded
        }
        if let imageData = company.imageData {
            companyImageView.image = UIImage(data: imageData)
            setupImage()
        } else {
            companyImageView.image = UIImage(systemName: "person.crop.circle.dashed")
        }
        
        founderTextField.text = company.founder
        
    }
    
    private func setupImage() {
        companyImageView.setCircularImageView()
    }
    
    @IBAction func didTapSelectImage(_ sender: Any) {
        let alertController = UIAlertController(title: "Choose a photo", message: "Select a picture from library or camera", preferredStyle: .actionSheet)
        
        let libraryAction = UIAlertAction(title: "Library", style: .default) { [weak self] _ in
            guard let self = self else { return }
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(libraryAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    private func didTapSave() {
        company != nil
            ? performEditCompany()
            : performCreateCompany()
    }
    
    private func performCreateCompany() {
        let context = CoreDataMaager.shared.context
        
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        company.setValue(companyNameTextField.text, forKey: "name")
        company.setValue(datePicker.date, forKey: "founded")
        company.setValue(founderTextField.text, forKey: "founder")
        if let image = companyImageView.image {
            let imageData = image.jpegData(compressionQuality: 0.8)
            company.setValue(imageData, forKey: "imageData")
        }
        
        do {
            try context.save()
            dismiss(animated: true) { [weak self] in
                guard let self = self else { return }
                self.delegate?.createCompanyController(self, didCreateCompany: company as! Company)
            }
        } catch {
            print("Failed to save company: \(error)")
        }
    }
    
    private func performEditCompany() {
        let context = CoreDataMaager.shared.context
        
        company?.name = companyNameTextField.text
        company?.founded = datePicker.date
        company?.founder = founderTextField.text
        if let image = companyImageView.image {
            let imageData = image.jpegData(compressionQuality: 0.8)
            company?.imageData = imageData
        }
        
        do {
            try context.save()
            dismiss(animated: true) { [weak self] in
                guard let self = self else { return }
                self.delegate?.createCompanyController(self, didEditCompany: company!)
            }
        } catch {
            print("Failed to edit company: \(error)")
        }
    }

}

extension CreateCompanyController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            companyImageView.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            companyImageView.image = originalImage
        }
        setupImage()
        dismiss(animated: true)
    }
}

//
//  TableViewController.swift
//  iOSLearningCircle
//
//  Created by Alberto Garcia on 02/05/23.
//

import UIKit

class CompaniesController: UITableViewController {
    
    var companies: [Company] = Company.samples
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Companies"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CompanyCell", bundle: .main),
                           forCellReuseIdentifier: "CompanyCell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.square.fill"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapAdd))
    }
    
    @objc
    private func didTapAdd() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "CreateCompanyController") as? CreateCompanyController else { return }
        controller.delegate = self
        let navController = UINavigationController(rootViewController: controller)
        present(navController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension CompaniesController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        companies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath) as! CompanyCell
        let company = companies[indexPath.row]
        cell.configure(company: company)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CompaniesController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "CreateCompanyController") as? CreateCompanyController else { return }
        controller.company = companies[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - CreateCompanyDelegate

extension CompaniesController: CreateCompanyDelegate {
    func createCompanyController(_ createCompanyController: CreateCompanyController, didCreateCompany company: Company) {
        companies.append(company)
        tableView.reloadData()
    }
}

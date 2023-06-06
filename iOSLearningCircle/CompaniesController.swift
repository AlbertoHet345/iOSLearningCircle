//
//  TableViewController.swift
//  iOSLearningCircle
//
//  Created by Alberto Garcia on 02/05/23.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController {
    
    var companies: [Company] = []
    
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
        
        fetchCompanies()
    }
    
    @objc
    private func didTapAdd() {
        navigate(company: nil, state: .add)
    }
    
    private func fetchCompanies() {

        let context = CoreDataMaager.shared.context
        
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try context.fetch(fetchRequest)
            self.companies = companies
            tableView.reloadData()
        } catch let fetchError {
            print("Failed to fetch companies: \(fetchError)")
        }
        
    }
    
    private func navigate(company: Company?, state: CreateCompanyControllerState) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "CreateCompanyController") as? CreateCompanyController else { return }
        controller.company = company
        controller.delegate = self
        controller.state = state
        if state != .detail {
            let navController = UINavigationController(rootViewController: controller)
            present(navController, animated: true)
        } else {
            navigationController?.pushViewController(controller, animated: true)
        }
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
        navigate(company: companies[indexPath.row], state: .detail)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive,
                                        title: "Delete") { [weak self] _, _, completionHandler in
            guard let self = self else { return }
            self.companies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        
        let editAction = UIContextualAction(style: .normal,
                                            title: "Edit") { [weak self] _, _, completionHandler in
            guard let self = self else { return }
            self.navigate(company: self.companies[indexPath.row], state: .edit)
            completionHandler(true)
        }
        editAction.backgroundColor = .systemBlue
        
        return UISwipeActionsConfiguration(actions: [action, editAction])
    }
}

// MARK: - CreateCompanyDelegate

extension CompaniesController: CreateCompanyDelegate {
    func createCompanyController(_ createCompanyController: CreateCompanyController, didEditCompany company: Company) {
        guard let row = companies.firstIndex(of: company) else { return }
        
        let indexPath = IndexPath(row: row, section: 0)
        tableView.reloadRows(at: [indexPath], with: .middle)
    }
    
    func createCompanyController(_ createCompanyController: CreateCompanyController, didCreateCompany company: Company) {
        companies.append(company)
        
        let indexPath = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}

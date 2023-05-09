//
//  TableViewController.swift
//  iOSLearningCircle
//
//  Created by Alberto Garcia on 02/05/23.
//

import UIKit

class TableViewController: UITableViewController {
    
    let companies: [Company] = Company.samples
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Table"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
    }

}

extension TableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        companies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
        let company = companies[indexPath.row]
        cell.textLabel?.text = company.name
        cell.detailTextLabel?.text = "\(company.foundationYear)"
        return cell
    }
}

extension TableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
        controller.nombre = companies[indexPath.row].name
        navigationController?.pushViewController(controller, animated: true)
    }
}

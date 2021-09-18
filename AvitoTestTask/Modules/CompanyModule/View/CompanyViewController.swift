//
//  CompanyViewController.swift
//  AvitoTestTask
//
//  Created by Максим Алексеев  on 14.09.2021.
//

import UIKit

class CompanyViewController: UIViewController {
    // MARK:- Dependencies
    var viewModel: CompanyViewModelProtocol! {
        didSet {
            viewModel.employeeBinder = { [weak self] viewModel in
                self?.employeeTableView.reloadData()
            }
            
            viewModel.errorBinder = { [weak self] error in
                self?.showErrorAlert(error: error)
            }
        }
    }
    
    // MARK:- Const
    private let cellId = "CompanyViewControllerCellId"
    
    // MARK:- Views
    private lazy var employeeTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EmployeeTableViewCell.self, forCellReuseIdentifier: cellId)
        return tableView
    }()
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationBar()
        viewModel.loadEmpoyees()
    }

    // MARK:- Setups
    private func setupTableView() {
        view.addSubview(employeeTableView)
        NSLayoutConstraint.activate([
            employeeTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            employeeTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            employeeTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            employeeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupNavigationBar() {
        title = "Avito"
    }
    
    // MARK:- Private function
    private func showErrorAlert(error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Try again", style: .cancel)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
}

// MARK:- UITableViewDelegate
extension CompanyViewController: UITableViewDelegate {
    
}

// MARK:- UITableViewDataSource
extension CompanyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? EmployeeTableViewCell else { return UITableViewCell() }
        let employee = viewModel.employees[indexPath.row]
        cell.configureNameLabel(with: employee.name)
        cell.configureSkillsLabel(with: employee.skills.joined(separator: "\n"))
        cell.configurePhoneNumberLabel(with: employee.phoneNumber)
        return cell
    }
}

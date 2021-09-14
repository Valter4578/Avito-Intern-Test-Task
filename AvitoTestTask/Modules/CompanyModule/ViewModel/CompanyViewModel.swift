//
//  CompanyViewModel.swift
//  AvitoTestTask
//
//  Created by Максим Алексеев  on 14.09.2021.
//

import Foundation

protocol CompanyViewModelProtocol {
    var employeeBinder: ((CompanyViewModelProtocol) -> ())? { get set }
    var employees: [Employee] { get }
    
    var errorBinder: ((Error) -> ())? { get set }
    func loadEmpoyees()
}

class CompanyViewModel: CompanyViewModelProtocol {
    // MARK:- Dependencies
    private var networkService: NetworkService!
    
    // MARK:- Properties
    var employeeBinder: ((CompanyViewModelProtocol) -> ())?
    private(set) var employees: [Employee] = [] {
        didSet {
            employeeBinder?(self)
        }
    }
    
    var errorBinder: ((Error) -> ())?
    
    // MARK:- Private
    
    // MARK:- Functions
    func loadEmpoyees() {
        networkService.getCompany { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let company):
                    self?.employees = company.employees
                case .failure(let error):
                    self?.errorBinder?(error)
                }
            }
        }
    }
    
    // MARK:- Inits
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

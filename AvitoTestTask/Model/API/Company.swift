//
//  Company.swift
//  AvitoTestTask
//
//  Created by Максим Алексеев  on 14.09.2021.
//

import Foundation

struct Company: Codable {
    let name: String
    let employees: [Employee]
}

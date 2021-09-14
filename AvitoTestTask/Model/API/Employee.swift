//
//  Employee.swift
//  AvitoTestTask
//
//  Created by Максим Алексеев  on 14.09.2021.
//

import Foundation

struct Employee: Codable {
    let name: String
    let phoneNumber: String
    let skills: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case phoneNumber = "phone_number"
        case skills 
    }
}

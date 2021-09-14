//
//  NetworkService.swift
//  AvitoTestTask
//
//  Created by Максим Алексеев  on 14.09.2021.
//

import Foundation

protocol NetworkService {
    func getCompany(completion: @escaping (Result<Company, Error>) -> ()) 
}

class DefaultNetworkService: NetworkService {
    // MARK:- Private
    private let defaultSession: URLSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    private let baseUrl = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
    
    // MARK:- Functions
    func getCompany(completion: @escaping (Result<Company, Error>) -> ()) {
        guard let url = URL(string: baseUrl) else { return }
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
          
            if let response = response as? HTTPURLResponse,
               response.statusCode == 200,
               let data = data {
                do {
                    let dataResponse = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(dataResponse.company))
                } catch {
                    print(String(data: data, encoding: .utf8))
                    print(error)
                }
            }
        }
        
        dataTask?.resume()  
    }
}

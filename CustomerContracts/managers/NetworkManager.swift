//
//  NetworkManager.swift
//  CustomerContracts
//
//  Created by Habip Yeşilyurt on 4.08.2023.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    func fetchInvoices(completion: @escaping (ResultTypeEnum<InvoiceResponseModel>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    
    private init () {}
    
    func fetchInvoices(completion: @escaping (ResultTypeEnum<InvoiceResponseModel>) -> Void) {
        let urlString = "https://raw.githubusercontent.com/bydevelopertr/enerjisa/main/userInvoices.json"
        AF.request(urlString, method: .get).responseDecodable(of: InvoiceResponseModel.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                completion(.failure(.fetchError))
            }
        }
    }
}

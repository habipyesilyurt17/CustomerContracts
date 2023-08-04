//
//  InvoiceListVM.swift
//  CustomerContracts
//
//  Created by Habip Yeşilyurt on 2.08.2023.
//

import UIKit

protocol InvoiceListVMProtocol {
    var delegate: InvoiceListVMDelegate? { get set }
    func fetchInvoices()
    func getInvoiceCount() -> Int
    func getCompanyList(at index: Int) -> List?
}

protocol InvoiceListVMDelegate: AnyObject {
    func invoicesLoaded()
}

final class InvoiceListVM: InvoiceListVMProtocol {
    weak var delegate: InvoiceListVMDelegate?
    public var invoices : InvoiceResponseModel?
    
    func fetchInvoices() {
        NetworkManager.shared.fetchInvoices { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.invoices = response
                self.delegate?.invoicesLoaded()
            case .failure(let errorMessage):
                print(errorMessage.rawValue)
            }
        }
    }
    
    func getInvoiceCount() -> Int {
        self.invoices?.list.count ?? 0
    }
    
    func getCompanyList(at index: Int) -> List? {
        self.invoices?.list[index]
    }
}

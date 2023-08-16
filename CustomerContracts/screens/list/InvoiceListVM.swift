//
//  InvoiceListVM.swift
//  CustomerContracts
//
//  Created by Habip Yeşilyurt on 2.08.2023.
//

import UIKit

protocol InvoiceListVMInterface {    
    func viewDidLoad()
    func numberOfItemsInSection() -> Int
    func getCompanyList(at index: Int) -> List?
}

protocol InvoiceListVMDelegate: AnyObject {
    func invoicesFetched()
}


final class InvoiceListVM {
    weak var delegate: InvoiceListVMDelegate?

    weak var view: InvoiceListInterface?
    private var invoices: InvoiceResponseModel?
    private let networkManager: NetworkManagerInterface
    
    init(view: InvoiceListInterface?, networkManager: NetworkManagerInterface = NetworkManager.shared) {
        self.view = view
        self.networkManager = networkManager
    }
    
    private func fetchInvoices() {
        view?.startIndicator()
        networkManager.fetchInvoices { [weak self] result in
            guard let self = self else { return }
            self.view?.stopIndicator()
            switch result {
            case .success(let invoices):
                self.invoices = invoices
                self.view?.contractInvoices = self.invoices
                self.delegate?.invoicesFetched()
            case .failure(let errorMessage):
                print(errorMessage.rawValue)
            }
        }
    }
}

extension InvoiceListVM: InvoiceListVMInterface {    
    func viewDidLoad() {
        view?.prepareNavigation()
        view?.prepareTableView()
        fetchInvoices()
    }
    
    func numberOfItemsInSection() -> Int {
        self.invoices?.list.count ?? 0
    }

    func getCompanyList(at index: Int) -> List? {
        self.invoices?.list[index]
    }
}


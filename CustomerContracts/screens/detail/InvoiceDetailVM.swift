//
//  InvoiceDetailVM.swift
//  CustomerContracts
//
//  Created by Habip Yeşilyurt on 4.08.2023.
//

import UIKit

protocol InvoiceDetailVMProtocol {
    var delegate : InvoiceDetailVMDelegate? { get set }
    func getCompanyInvoice(at index: Int) -> Invoice?
}

protocol InvoiceDetailVMDelegate : AnyObject {
    func gameDetailLoaded()
}


final class InvoiceDetailVM: InvoiceDetailVMProtocol {
    weak var delegate: InvoiceDetailVMDelegate?
    public var invoices: [Invoice] = []
    
    func getCompanyInvoice(at index: Int) -> Invoice? {
        self.invoices[index]
    }
}

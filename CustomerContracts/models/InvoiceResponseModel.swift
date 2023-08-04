//
//  InvoiceResponseModel.swift
//  CustomerContracts
//
//  Created by Habip Yeşilyurt on 4.08.2023.
//

import Foundation

struct InvoiceResponseModel: Decodable {
    let totalPrice: String
    let totalPriceCount: Int
    let list: [List]
    let invoices: [Invoice]
}

struct Invoice: Decodable {
    let legacyContractAccountNumber: String
    let installationNumber: String
    let documentNumber: String
    let amount: String
    let currency: String
    let dueDate: String
}

struct List: Decodable {
    let company: String
    let installationNumber: String
    let contractAccountNumber: String
    let amount: String
    let address: String
}

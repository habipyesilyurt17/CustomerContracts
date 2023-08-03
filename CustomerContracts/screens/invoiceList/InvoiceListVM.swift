//
//  InvoiceListVM.swift
//  CustomerContracts
//
//  Created by Habip Yeşilyurt on 2.08.2023.
//

import UIKit

protocol InvoiceListVMProtocol {
    func viewDidLoad()
    func numberOfSections() -> Int
    func cellForItemAt(at indexPath: IndexPath, tableView: UITableView) -> UITableViewCell
}

final class InvoiceListVM {
    private weak var view: InvoiceListViewProtocol?
    
    init(view: InvoiceListViewProtocol) {
        self.view = view
    }
}

extension InvoiceListVM: InvoiceListVMProtocol {
    func viewDidLoad() {
        view?.prepareCustomView()
        view?.prepareTitleLabel()
        view?.preparePaymentNotificationView()
        view?.prepareTableView()
    }
    
    func numberOfSections() -> Int {
        2
    }
    
    func cellForItemAt(at indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceTableViewCell", for: indexPath) as! InvoiceTableViewCell

//        cell.configure()
        return cell
    }
}

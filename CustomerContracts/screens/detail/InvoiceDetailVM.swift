//
//  InvoiceDetailVM.swift
//  CustomerContracts
//
//  Created by Habip Yeşilyurt on 4.08.2023.
//

import UIKit

protocol InvoiceDetailVMProtocol {
    func viewWillAppear()
    func viewDidLoad()
    func viewForHeaderInSection(tableView: UITableView, section: Int) -> UIView?
    func numberOfRowsInSection() -> Int
    func cellForItemAt(at indexPath: IndexPath, tableView: UITableView) -> UITableViewCell
}


final class InvoiceDetailVM {
    private weak var view: InvoiceDetailViewProtocol?
    
    init(view: InvoiceDetailViewProtocol) {
        self.view = view
    }
}


extension InvoiceDetailVM: InvoiceDetailVMProtocol {
    func viewWillAppear() {
        view?.prepareCustomView()
        view?.prepareNavigationItem()
        view?.prepareErrorLabel()
    }
    
    func viewDidLoad() {
        view?.preparePlumbingDetailView()
        view?.prepareDebtContainerView()
        view?.prepareTableView()
    }
    
    func numberOfRowsInSection() -> Int {
        3
    }
    
    func viewForHeaderInSection(tableView: UITableView, section: Int) -> UIView? {
        if section == 0 {
            let headerView = CustomHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 46.0))
            return headerView
        }
        return nil
    }
    
    func cellForItemAt(at indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceDetailTableViewCell", for: indexPath) as! InvoiceDetailTableViewCell
        return cell
    }
}

//
//  InvoiceListVC.swift
//  CustomerContracts
//
//  Created by Habip Yeşilyurt on 2.08.2023.
//

import UIKit

protocol InvoiceListInterface: AnyObject {
    var contractInvoices: InvoiceResponseModel? { get set }
    
    func prepareNavigation()
    func preparePaymentNotificationView()
    func prepareTableView()
    func startIndicator()
    func stopIndicator()
}

final class InvoiceListVC: BaseVC {
    @IBOutlet weak var paymentNotificationView: UIView!
    @IBOutlet weak var paymentNotificationLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!


    private lazy var viewModel = InvoiceListVM(view: self)
    public var contractInvoices : InvoiceResponseModel?


    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
}


//Mark: - UI
extension InvoiceListVC: InvoiceListInterface {
    func prepareNavigation() {
        let customHeaderView = CustomHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 88))
        customHeaderView.setTitle("FATURA LİSTESİ")
        view.addSubview(customHeaderView)
    }
    
    func preparePaymentNotificationView() {
        paymentNotificationView.layer.cornerRadius = 10
        paymentNotificationView.layer.shadowColor = UIColor.black.cgColor
        paymentNotificationView.layer.shadowOpacity = 0.2
        paymentNotificationView.layer.shadowOffset = CGSize(width: 5, height: 5)
        paymentNotificationView.layer.shadowRadius = 20
        paymentNotificationView.layer.shadowPath = UIBezierPath(roundedRect: paymentNotificationView.bounds, cornerRadius: paymentNotificationView.layer.cornerRadius).cgPath

        view.addSubview(paymentNotificationView)
        
        guard let invoices = contractInvoices else { return }
        
        let totalPrice =  invoices.totalPrice
        let totalPriceCount = invoices.totalPriceCount
        paymentNotificationLabel.text = "Tüm sözleşme hesaplarınıza ait \(totalPriceCount) adet fatura bulunmaktadır."
        totalPriceLabel.text = "₺ \(totalPrice)"
    }

    func prepareTableView() {
        let cellNib = UINib(nibName: "InvoiceTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "InvoiceTableViewCell")
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 346
    }

    func startIndicator() {
        indicator.startAnimating()
    }
    
    func stopIndicator() {
        indicator.stopAnimating()
    }
}

extension InvoiceListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceTableViewCell", for: indexPath) as! InvoiceTableViewCell
        guard let model = viewModel.getCompanyList(at: indexPath.row) else { return UITableViewCell() }
        cell.configureCell(item: model)
        cell.delegate = self
        return cell
    }
}

extension InvoiceListVC: InvoiceListVMDelegate {
    func invoicesFetched() {
        tableView.reloadData()
        preparePaymentNotificationView()
    }
}

extension InvoiceListVC: InvoiceTableViewCellDelegate {
    func didTapButton(in cell: InvoiceTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let selectedList = contractInvoices?.list[indexPath.row]
        let invoiceDetailVC =  InvoiceDetailVC()
        invoiceDetailVC.choosenList = selectedList
        
        let filteredInvoices = contractInvoices?.invoices.filter { invoice in
            return invoice.installationNumber == selectedList?.installationNumber
        }
        invoiceDetailVC.choosenInvoices = filteredInvoices ?? []
        navigationController?.pushViewController(invoiceDetailVC, animated: true)
    }
}

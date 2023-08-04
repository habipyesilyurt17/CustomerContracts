//
//  InvoiceListVC.swift
//  CustomerContracts
//
//  Created by Habip Yeşilyurt on 2.08.2023.
//

import UIKit

final class InvoiceListVC: UIViewController {
    @IBOutlet weak var paymentNotificationView: UIView!
    @IBOutlet weak var paymentNotificationLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let customView = CustomView()
    let titleLabel = UILabel()

    private var viewModel = InvoiceListVM()
    public var contractInvoices : InvoiceResponseModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCustomView()
        prepareTitleLabel()
        preparePaymentNotificationView()
        prepareTableView()
        viewModel.delegate = self
        viewModel.fetchInvoices()
        contractInvoices = viewModel.invoices
    }

}

extension InvoiceListVC: InvoiceListVMDelegate {
    func invoicesLoaded() {
        tableView.reloadData()
        contractInvoices = viewModel.invoices
        preparePaymentNotificationView()
    }
}


//Mark: - UI
extension InvoiceListVC {
    func prepareTableView() {
        let cellNib = UINib(nibName: "InvoiceTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "InvoiceTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 346
    }
    
    func prepareCustomView() {
        customView.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(customView)
        
        let gradientColor = [
            UIColor(red: 0.99, green: 0.93, blue: 0.31, alpha: 1.00).cgColor,
            UIColor(red: 0.93, green: 0.65, blue: 0.25, alpha: 1.00).cgColor
        ]
        
        customView.backgroundColor = UIColor.gradientColor(from: gradientColor, with: UIScreen.main.bounds)
        
        NSLayoutConstraint.activate([
             customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             customView.topAnchor.constraint(equalTo: view.topAnchor),
             customView.heightAnchor.constraint(equalToConstant: 88)
         ])
    }
    
    func prepareTitleLabel() {
        titleLabel.text = "FATURA LİSTESİ"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        customView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: customView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: customView.topAnchor, constant: 60)
        ])
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
        
        let totalPrice =  invoices.totalPrice  //"12.454,10"
        let totalPriceCount = invoices.totalPriceCount //5
        paymentNotificationLabel.text = "Tüm sözleşme hesaplarınıza ait \(totalPriceCount) adet fatura bulunmaktadır."
        totalPriceLabel.text = "₺ \(totalPrice)"
    }
}

extension InvoiceListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getInvoiceCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceTableViewCell", for: indexPath) as! InvoiceTableViewCell
        guard let model = viewModel.getCompanyList(at: indexPath.row) else { return UITableViewCell() }
        cell.delegate = self
        cell.configureCell(item: model)
        return cell
    }
}

extension InvoiceListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.rowHeight
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

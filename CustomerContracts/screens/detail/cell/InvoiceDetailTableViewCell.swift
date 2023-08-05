//
//  InvoiceDetailTableViewCell.swift
//  CustomerContracts
//
//  Created by Habip Yeşilyurt on 4.08.2023.
//

import UIKit

class InvoiceDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var invoiceButton: UIButton!
    @IBOutlet weak var paymentButton: UIButton!
    
    var invoiceButtonTapped: ((_ documentNumber: String) -> Void)?
    var paymentButtonTapped: ((_ dueDate: String) -> Void)?
    var documentNumber = ""
    
    func configureCell(invoice: Invoice) {
        dueDateLabel.text = invoice.dueDate
        amountLabel.text = invoice.amount
        documentNumber = invoice.documentNumber
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        preparePaymentButton()
    }
    
    private func preparePaymentButton() {
//        paymentButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: paymentButton.frame.size.width - image!.size.width, bottom: 0, right: 0)
//        paymentButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -image!.size.width, bottom: 0, right: image!.size.width)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    @IBAction func invoiceButtonTapped(_ sender: Any) {
        invoiceButtonTapped?(documentNumber)
    }
    
    @IBAction func paymentButtonTapped(_ sender: Any) {
        paymentButtonTapped?(dueDateLabel.text ?? "")
    }
}

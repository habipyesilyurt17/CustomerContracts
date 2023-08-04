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
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    @IBAction func invoiceButtonTapped(_ sender: Any) {
    }
    
    @IBAction func paymentButtonTapped(_ sender: Any) {
    }
    
    
}

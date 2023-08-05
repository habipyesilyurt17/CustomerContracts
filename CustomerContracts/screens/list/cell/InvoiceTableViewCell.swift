//
//  InvoiceTableViewCell.swift
//  CustomerContracts
//
//  Created by Habip Yeşilyurt on 3.08.2023.
//

import UIKit

protocol InvoiceTableViewCellDelegate: AnyObject {
    func didTapButton(in cell: InvoiceTableViewCell)
}

final class InvoiceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var installationNumberLabel: UILabel!
    @IBOutlet weak var contractAccountNumberLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var viewButton: UIButton!
    
    weak var delegate: InvoiceTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareContainerView()
        prepareViewButton()
    }
    
    func configureCell(item: List) {
        companyLabel.text = item.company
        addressLabel.text = item.address
        installationNumberLabel.text = item.installationNumber
        contractAccountNumberLabel.text = item.contractAccountNumber
        amountLabel.text = item.amount
    }
    
    private func prepareViewButton() {
        viewButton.backgroundColor = UIColor.gradientColor(with: UIScreen.main.bounds)
        viewButton.tintColor = .white
        viewButton.layer.cornerRadius = 10

    }
    
    private func prepareContainerView() {
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor.systemGray6.cgColor
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shadowOffset = CGSize(width: 3, height: 3)
        containerView.layer.shadowRadius = 5
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: containerView.layer.cornerRadius).cgPath
    }
    
    @IBAction func viewButtonTapped(_ sender: Any) {
        delegate?.didTapButton(in: self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        companyLabel.text = nil
        addressLabel.text = nil
        installationNumberLabel.text = nil
        contractAccountNumberLabel.text = nil
        amountLabel.text = nil
    }
}

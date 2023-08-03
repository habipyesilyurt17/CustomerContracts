//
//  InvoiceTableViewCell.swift
//  CustomerContracts
//
//  Created by Habip Yeşilyurt on 3.08.2023.
//

import UIKit

final class InvoiceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var installationNumberLabel: UILabel!
    @IBOutlet weak var contractAccountNumberLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var viewButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareContainerView()
        prepareViewButton()
    }
    
    private func prepareViewButton() {
        let gradientColor = [
            UIColor(red: 0.99, green: 0.93, blue: 0.31, alpha: 1.00).cgColor,
            UIColor(red: 0.93, green: 0.65, blue: 0.25, alpha: 1.00).cgColor
        ]
        viewButton.backgroundColor = UIColor.gradientColor(from: gradientColor, with: UIScreen.main.bounds)
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
    }
    
}

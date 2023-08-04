//
//  CustomHeaderView.swift
//  CustomerContracts
//
//  Created by Habip Yeşilyurt on 4.08.2023.
//

import UIKit

class CustomHeaderView: UIView {
    let dueDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .center
//        label.font = .systemFont(ofSize: 15, weight: .bold)
        
        let attributedText = NSMutableAttributedString(string: "Vade\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
        attributedText.append(NSAttributedString(string: "Tarihi", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]))
        label.attributedText = attributedText
        return label
     }()
     
     let amountPayableLabel: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.numberOfLines = 2
         label.textAlignment = .center
//         label.font = .systemFont(ofSize: 15, weight: .bold)
         let attributedText = NSMutableAttributedString(string: "Ödenecek\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
         attributedText.append(NSAttributedString(string: "Tutar", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]))
         label.attributedText = attributedText
         return label
     }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(dueDateLabel)
        addSubview(amountPayableLabel)
        
        // Add constraints to position the labels within the header view
        NSLayoutConstraint.activate([
            dueDateLabel.topAnchor.constraint(equalTo: topAnchor, constant: -8),
            dueDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            dueDateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dueDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            amountPayableLabel.topAnchor.constraint(equalTo: topAnchor, constant: -8),
            amountPayableLabel.leadingAnchor.constraint(equalTo: dueDateLabel.trailingAnchor, constant: 66),
            amountPayableLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            amountPayableLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)

            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

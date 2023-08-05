//
//  CustomAlertVC.swift
//  CustomerContracts
//
//  Created by Habip Yeşilyurt on 5.08.2023.
//

import UIKit

class CustomAlertVC: UIViewController {
    @IBOutlet weak var alertTitle: UILabel!
    @IBOutlet weak var alertMessage: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var alertView: UIView!
    
    var customTitle: String?
    var customMessage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareAlertView()
        animateView()
        prepateOkButton()
        fillAlertLabel()
    }
    
    private func fillAlertLabel() {
        guard let customTitle = customTitle else { return }
        guard let customMessage = customMessage else { return }
        alertTitle.text = customTitle
        alertMessage.text = customMessage
    }


    @IBAction func okButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}


//Mark: - UI
extension CustomAlertVC {
    private func prepareAlertView() {
        alertView.layer.cornerRadius = 15
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    private func animateView() {
        alertView.alpha = 0
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 0
        UIView.animate(withDuration: 0.0) {
            self.alertView.alpha = 1.0
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 0
        }
    }
    
    private func prepateOkButton() {
        let gradientColor = [
            UIColor(red: 0.99, green: 0.93, blue: 0.31, alpha: 1.00).cgColor,
            UIColor(red: 0.93, green: 0.65, blue: 0.25, alpha: 1.00).cgColor
        ]
        okButton.backgroundColor = UIColor.gradientColor(from: gradientColor, with: UIScreen.main.bounds)
        okButton.tintColor = .white
        okButton.layer.cornerRadius = 10
    }
}

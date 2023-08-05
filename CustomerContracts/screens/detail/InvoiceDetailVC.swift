//
//  InvoiceDetailVC.swift
//  CustomerContracts
//
//  Created by Habip Yeşilyurt on 4.08.2023.
//

import UIKit

final class InvoiceDetailVC: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var tcTextField: UITextField!
    @IBOutlet weak var tcErrorLabel: UILabel!
    @IBOutlet weak var epostaTextField: UITextField!
    @IBOutlet weak var epostaErrorLabel: UILabel!
    @IBOutlet weak var telTextField: UITextField!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var installationNumberLabel: UILabel!
    @IBOutlet weak var contractAccountNumberLabel: UILabel!
    @IBOutlet weak var contractContentLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var plumbingDetailView: UIView!
    @IBOutlet weak var debtContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
  
    let customView = CustomView()
    
    var choosenList: List?
    var choosenInvoices: [Invoice] = []
    private var viewModel = InvoiceDetailVM()
    let maxLength = 11

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareCustomView()
        prepareNavigationItem()
        prepareErrorLabel()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        preparePlumbingDetailView()
        prepareDebtContainerView()
        prepareTableView()
        prepareListLabel()
        prepareTcTextField()
    }
    
    private func prepareTcTextField() {
        tcTextField.delegate = self
        tcTextField.keyboardType = .numberPad
        tcTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.count > maxLength {
            textField.deleteBackward()
        }
    }
}




//Mark: - UI
extension InvoiceDetailVC {
    private func prepareListLabel() {
        companyLabel.text = choosenList?.company
        addressLabel.text = choosenList?.address
        installationNumberLabel.text = choosenList?.installationNumber
        contractAccountNumberLabel.text = choosenList?.contractAccountNumber
        amountLabel.text = choosenList?.amount
        contractContentLabel.text = "Seçili sözleşme hesabınıza ait \(choosenInvoices.count) adet ödenmemiş fatura bulunmaktadır."
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
             customView.heightAnchor.constraint(equalToConstant: 90)
         ])
    }
    
    func prepareNavigationItem() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        let backButtonImage = UIImage(named: "back")
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
        
        
        let titleLabel = UILabel()
        titleLabel.text = "FATURA DETAYI"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        navigationItem.titleView = titleLabel
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func prepareErrorLabel() {
        tcErrorLabel.isHidden = true
        epostaErrorLabel.isHidden = true
    }
    
    func preparePlumbingDetailView() {
        addShadowToView(view: plumbingDetailView)
    }
    
    func prepareDebtContainerView() {
        addShadowToView(view: debtContainerView)
    }
    
    private func addShadowToView(view: UIView) {
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.layer.shadowRadius = 20
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.layer.cornerRadius).cgPath
    }
    
    func prepareTableView() {
        let cellNib = UINib(nibName: "InvoiceDetailTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "InvoiceDetailTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension InvoiceDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = CustomHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 46.0))
            return headerView
        }
        return nil
    }
}

extension InvoiceDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        choosenInvoices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceDetailTableViewCell", for: indexPath) as! InvoiceDetailTableViewCell
        cell.configureCell(invoice: choosenInvoices[indexPath.row])
        
        cell.invoiceButtonTapped = { [weak self] documentNumber in
            let title = "Döküman Numarası"
            let message = "Bu faturaya ait döküman numarası \(documentNumber)’dir. Bu numaraya istinaden işlemlerinizi gerçekleştirebilirsiniz."
            
            self?.showCustomAlert(title: title, message: message)
        }
        
        cell.paymentButtonTapped = { [weak self] dueDate in
            let title = "Son Ödeme Tarihi"
            let message = "Bu fatura \(dueDate) tarihine kadar ödenmesi gerekmektedir."
            self?.showCustomAlert(title: title, message: message)
        }
        
        return cell
    }
    
    func showCustomAlert(title: String, message: String) {
        let customAlertVC = CustomAlertVC(nibName: "CustomAlertVC", bundle: nil)
        customAlertVC.modalPresentationStyle = .overCurrentContext
        customAlertVC.providesPresentationContextTransitionStyle = true
        customAlertVC.definesPresentationContext = true
        customAlertVC.modalTransitionStyle = .crossDissolve
        
        customAlertVC.customTitle  = title
        customAlertVC.customMessage = message

        self.present(customAlertVC, animated: true, completion: nil)
    }
}

extension InvoiceDetailVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text {
            if text.isEmpty {
                tcTextField.layer.borderColor = UIColor.systemGray5.cgColor
                tcErrorLabel.text = ""
            } else if text.count == maxLength {
                let isValid = validateTurkishIDNumber(text)
                updateUIForValidation(isValid)
            }
        }
     }
    
    func updateUIForValidation(_ isValid: Bool) {
        if isValid {
            tcErrorLabel.isHidden = true
        } else {
            tcTextField.layer.borderWidth = 1.0
            tcTextField.layer.borderColor = UIColor.red.cgColor
            tcErrorLabel.isHidden = false
            tcErrorLabel.text = "Girdiğiniz T.C. Kimlik numarası doğru değildir"
            tcErrorLabel.textColor = UIColor.red
        }
    }
    
    func validateTurkishIDNumber(_ identityNumber: String) -> Bool {
        let tcNumber = identityNumber.trimmingCharacters(in: .whitespacesAndNewlines)

        guard tcNumber.count == maxLength, let _ = Int(tcNumber) else {
            return false
        }
        
        guard tcNumber.first != "0" else {
            return false
        }
        
        let digits = tcNumber.compactMap { Int(String($0)) }
        
        let oddSum = digits.enumerated().filter { $0.offset % 2 == 0 && $0.offset < 9 }.map { $0.element }.reduce(0, +)
        let evenSum = digits.enumerated().filter { $0.offset % 2 == 1 && $0.offset < 9 }.map { $0.element }.reduce(0, +)
        let tenthDigit = (oddSum * 7 - evenSum) % 10
        
        let sumOfFirstTen = digits.prefix(10).reduce(0, +)
        let eleventhDigit = sumOfFirstTen % 10
        
        return digits[9] == tenthDigit && digits[10] == eleventhDigit
     }
}

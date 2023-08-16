//
//  InvoiceDetailVC.swift
//  CustomerContracts
//
//  Created by Habip Yeşilyurt on 4.08.2023.
//

import UIKit

protocol InvoiceDetailInterface: AnyObject {
    var choosenInvoices: [Invoice] { get set }
    
    func prepareNavigation()
    func prepareErrorLabel()
    func preparePlumbingDetailView()
    func prepareDebtContainerView()
    func prepareTableView()
    func prepareListLabel()
    func prepareTcTextField()
}

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
    
    private lazy var viewModel = InvoiceDetailVM(view: self)
      
    var choosenList: List?
    var choosenInvoices: [Invoice] = []
    let maxLength = 11

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        viewModel.delegate = self
    }
}

//Mark: - UI
extension InvoiceDetailVC: InvoiceDetailInterface {
    func prepareNavigation() {
        let customHeaderView = CustomHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 88))
        customHeaderView.setTitle("FATURA DETAYI")
        view.addSubview(customHeaderView)

        let backButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
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
    
    func prepareListLabel() {
        companyLabel.text = choosenList?.company
        addressLabel.text = choosenList?.address
        installationNumberLabel.text = choosenList?.installationNumber
        contractAccountNumberLabel.text = choosenList?.contractAccountNumber
        amountLabel.text = choosenList?.amount
        contractContentLabel.text = "Seçili sözleşme hesabınıza ait \(choosenInvoices.count) adet ödenmemiş fatura bulunmaktadır."
    }
    
    func prepareTcTextField() {
        tcTextField.delegate = self
        tcTextField.keyboardType = .numberPad
        tcTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        viewModel.textFieldDidChange(textField)
    }
}

extension InvoiceDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        viewModel.viewForHeaderInSection(tableView: tableView, section: section)
    }
}

extension InvoiceDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.cellForItemAt(at: indexPath, tableView: tableView)
    }
}

extension InvoiceDetailVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        viewModel.textField(textField, replacementString: string)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text {
            if text.isEmpty {
                tcTextField.layer.borderColor = UIColor.systemGray5.cgColor
                tcErrorLabel.text = ""
            } else if text.count == maxLength {
                let isValid = viewModel.validateTurkishIDNumber(text)
                updateUIForValidation(isValid)
            }
        }
     }
    
    func updateUIForValidation(_ isValid: Bool) {
        if isValid {
            tcErrorLabel.isHidden = true
        } else {
            tcTextField.layer.borderWidth = 1.0
            tcTextField.layer.cornerRadius = 5
            tcTextField.layer.borderColor = UIColor.red.cgColor
            tcErrorLabel.isHidden = false
            tcErrorLabel.text = Constants.TC_Error_Message
            tcErrorLabel.textColor = UIColor.red
        }
    }
}

extension InvoiceDetailVC: InvoiceDetailVMDelegate {
    func showCustomAlert(title: String, message: String) {
        let customAlertVC = CustomAlertVC(nibName: "CustomAlertVC", bundle: nil)
        customAlertVC.modalPresentationStyle = .overCurrentContext
        customAlertVC.providesPresentationContextTransitionStyle = true
        customAlertVC.definesPresentationContext = true
        customAlertVC.modalTransitionStyle = .crossDissolve
        customAlertVC.customTitle  = title
        customAlertVC.customMessage = message
        present(customAlertVC, animated: true, completion: nil)
    }
}

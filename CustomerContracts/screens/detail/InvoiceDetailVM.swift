//
//  InvoiceDetailVM.swift
//  CustomerContracts
//
//  Created by Habip Yeşilyurt on 16.08.2023.
//

import UIKit

protocol InvoiceDetailVMInterface {
    func viewWillAppear()
    func viewDidLoad()
    func viewForHeaderInSection(tableView: UITableView, section: Int) -> UIView?
    func numberOfRowsInSection() -> Int
    func cellForItemAt(at indexPath: IndexPath, tableView: UITableView) -> UITableViewCell
    func textFieldDidChange(_ textField: UITextField)
    func textField(_ textField: UITextField, replacementString string: String) -> Bool
    func validateTurkishIDNumber(_ identityNumber: String) -> Bool
}

protocol InvoiceDetailVMDelegate: AnyObject {
    func showCustomAlert(title: String, message: String)
}

final class InvoiceDetailVM {
    weak var view: InvoiceDetailInterface?
    weak var delegate: InvoiceDetailVMDelegate?
    let maxLength = 11
    
    init(view: InvoiceDetailInterface?) {
        self.view = view
    }
}

extension InvoiceDetailVM: InvoiceDetailVMInterface {
    func viewWillAppear() {
        view?.prepareNavigation()
        view?.prepareErrorLabel()
    }
    
    func viewDidLoad() {
        view?.preparePlumbingDetailView()
        view?.prepareDebtContainerView()
        view?.prepareTableView()
        view?.prepareListLabel()
        view?.prepareTcTextField()
    }
    
    func viewForHeaderInSection(tableView: UITableView, section: Int) -> UIView? {
        if section == 0 {
            let headerView = CustomTableViewHeader(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 46.0))
            return headerView
        }
        return nil
    }
    
    func numberOfRowsInSection() -> Int {
        view?.choosenInvoices.count ?? 0
    }
    
    func cellForItemAt(at indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceDetailTableViewCell", for: indexPath) as! InvoiceDetailTableViewCell
        guard let view = view else { return cell }
        
        cell.configureCell(invoice: view.choosenInvoices[indexPath.row])
        
        cell.invoiceButtonTapped = { [weak self] documentNumber in
            let title = Constants.Document_Number_Alert_Title
            let message = Constants.documentNumberAlertMessage(documentNumber: documentNumber)
            self?.showAlert(title: title, message: message)
        }
        
        cell.paymentButtonTapped = { [weak self] dueDate in
            let title = Constants.Due_Date_Alert_Title
            let message = Constants.dueDateAlertMessage(dueDate: dueDate)
            self?.showAlert(title: title, message: message)
        }
        
        return cell
    }
    
    private func showAlert(title: String, message: String) {
        delegate?.showCustomAlert(title: title, message: message)
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.count > maxLength {
            textField.deleteBackward()
        }
    }
    
    func textField(_ textField: UITextField, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func validateTurkishIDNumber(_ identityNumber: String) -> Bool {
        let tcNumber = identityNumber.trimmingCharacters(in: .whitespacesAndNewlines)

        guard tcNumber.count == maxLength, let _ = Int(tcNumber) else { return false }
        
        guard tcNumber.first != "0" else { return false }
        
        let digits = tcNumber.compactMap { Int(String($0)) }
        
        let oddSum = digits.enumerated().filter { $0.offset % 2 == 0 && $0.offset < 9 }.map { $0.element }.reduce(0, +)
        let evenSum = digits.enumerated().filter { $0.offset % 2 == 1 && $0.offset < 9 }.map { $0.element }.reduce(0, +)
        let tenthDigit = (oddSum * 7 - evenSum) % 10
        
        let sumOfFirstTen = digits.prefix(10).reduce(0, +)
        let eleventhDigit = sumOfFirstTen % 10
        
        return digits[9] == tenthDigit && digits[10] == eleventhDigit
     }
}

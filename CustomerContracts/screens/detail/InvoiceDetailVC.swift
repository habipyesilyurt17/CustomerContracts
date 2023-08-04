//
//  InvoiceDetailVC.swift
//  CustomerContracts
//
//  Created by Habip Yeşilyurt on 4.08.2023.
//

import UIKit

protocol InvoiceDetailViewProtocol: AnyObject {
    func prepareCustomView()
    func prepareNavigationItem()
    func prepareErrorLabel()
    func preparePlumbingDetailView()
    func prepareDebtContainerView()
    func prepareTableView()
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
  
    let customView = CustomView()
    private lazy var viewModel = InvoiceDetailVM(view: self)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

extension InvoiceDetailVC: InvoiceDetailViewProtocol {
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

//
//  BaseVC.swift
//  CustomerContracts
//
//  Created by Habip Yeşilyurt on 2.08.2023.
//

import UIKit
import MaterialActivityIndicator

class BaseVC: UIViewController {
    var indicator = MaterialActivityIndicatorView()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareActivityIndicatorView()
    }
    
    private func prepareActivityIndicatorView() {
        indicator = MaterialActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.center = view.center
        indicator.color = UIColor(named: "IndicatorColor")!
        view.addSubview(indicator)
    }
}

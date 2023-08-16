//
//  Constants.swift
//  CustomerContracts
//
//  Created by Habip Yeşilyurt on 16.08.2023.
//

import Foundation

struct Constants {
    static let TC_Error_Message = "Girdiğiniz T.C. Kimlik numarası doğru değildir."
    static let Document_Number_Alert_Title = "Döküman Numarası"
    static let Due_Date_Alert_Title = "Son Ödeme Tarihi"

    static func documentNumberAlertMessage(documentNumber: String) -> String {
        "Bu faturaya ait döküman numarası \(documentNumber)’dir. Bu numaraya istinaden işlemlerinizi gerçekleştirebilirsiniz."
    }
    static func dueDateAlertMessage(dueDate: String) -> String {
        "Bu fatura \(dueDate) tarihine kadar ödenmesi gerekmektedir."
    }
    static func paymentNotificationMessage(totalPriceCount: Int) -> String {
        "Tüm sözleşme hesaplarınıza ait \(totalPriceCount) adet fatura bulunmaktadır."
    }
}

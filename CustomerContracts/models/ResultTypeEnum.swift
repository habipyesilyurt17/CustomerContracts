//
//  ResultTypeEnum.swift
//  CustomerContracts
//
//  Created by Habip Yeşilyurt on 4.08.2023.
//

import Foundation

enum ResultTypeEnum<Value> {
    case success(Value)
    case failure(ErrorTypeEnum)
}

//
//  Struct.swift
//  CashMachineApp
//
//  Created by Serg on 25/06/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation

struct RegisteredDigits {
    let name: String
    let code: String
    let priceCurrency: String
    let priceValue: Double
    let tax: TaxMode
}

struct ScunnedDigits {
    let code: String
    let quantity: Double
}

struct ListOfItems {
    let description: String
}

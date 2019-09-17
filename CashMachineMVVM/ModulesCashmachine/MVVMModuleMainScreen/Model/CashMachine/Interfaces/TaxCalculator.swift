//
//  TaxCalculator.swift
//  CashMachine
//
//  Created by Serg on 17/03/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation

protocol TaxCalculator {
    
    func countTax(array: [TaxableItem]) -> Double
    
}

struct TaxableItem {
    var price: Double
    var quantity: Double
    var taxes: TaxMode
}

enum TaxesMode: Double {
    case Excise = 100
    case NDS = 0.1
}

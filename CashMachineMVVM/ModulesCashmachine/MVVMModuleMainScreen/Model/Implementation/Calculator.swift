//
//  Calculator.swift
//  CashMachine
//
//  Created by Serg on 23/03/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation

class Calculator {
    
}

extension Calculator: TaxCalculator {
    func countTax(array: [TaxableItem]) -> Double {
        var totalTax = 0.0
        for i in array {
            if i.taxes == .NDS {
                totalTax += i.price * i.taxes.rawValue * i.quantity
            } else {
                totalTax += i.taxes.rawValue * i.quantity
            }
        }
        return round(totalTax)
    }
}

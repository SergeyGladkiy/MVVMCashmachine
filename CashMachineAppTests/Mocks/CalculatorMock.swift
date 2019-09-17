//
//  CalculatorMock.swift
//  CashMachineAppTests
//
//  Created by Serg on 18/07/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation
@testable import CashMachineApp

class CalculatorMock: TaxCalculator {
    func countTax(array: [TaxableItem]) -> Double {
        let item = EntityMocker.generateTaxableItem()
        if item.taxes == .NDS {
             return round(item.price * item.taxes.rawValue * item.quantity)
        } else {
            return round(item.price * item.taxes.rawValue * item.quantity)
        }
    }
}

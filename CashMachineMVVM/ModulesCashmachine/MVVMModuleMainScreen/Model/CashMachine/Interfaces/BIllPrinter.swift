//
//  BIllPriner.swift
//  CashMachine
//
//  Created by Serg on 17/03/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation

protocol BillPrinter: MakeBill {
    
    func countBill(array: [PrintableItem], cachierInf: String, totalTax: Double, sum: Double) -> String
    
}

struct PrintableItem {
    let code: String
    let name: String
    let quantity: Double
    let priceValue: Double
    var fullPrice: Double {
        return quantity * priceValue
    }
}



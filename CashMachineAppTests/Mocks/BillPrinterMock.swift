//
//  BillPrinterMock.swift
//  CashMachineAppTests
//
//  Created by Serg on 18/07/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation
@testable import CashMachineApp

class BillPrinterMock {
    private weak var check: MakeBill!
    init(check: MakeBill) {
        self.check = check
    }
}

extension BillPrinterMock: BillPrinter {
    func countBill(array: [PrintableItem], cachierInf: String, totalTax: Double, sum: Double) -> String {
        
        let item = EntityMocker.generatePrintableItem()
        
        var bill = String()
        
        
        bill += ("\(item.code) \(item.name) \(item.quantity)x\(item.priceValue)\n\t\t\t\t\t\t\t\t=\(item.fullPrice)\n")
        bill += "\nСУММАРНЫЙ НАЛОГ:\t\t\t    =\(totalTax)\n"
        bill += "\nПРОМЕЖУТОЧНЫЙ ИТОГ:\t\t\t    =\(sum)\n\n"
        bill += "CashMachine №1:\n\(cachierInf)\n"
        
        return bill
    }
    
    func printCheck(_ data: String) {
        check.printCheck(data)
    }
}

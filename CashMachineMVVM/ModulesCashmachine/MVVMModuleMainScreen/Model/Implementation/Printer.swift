//
//  Printer.swift
//  CashMachine
//
//  Created by Serg on 23/03/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation

class Printer {
    private weak var check: MakeBill!
    init(check: MakeBill) {
        self.check = check
    }
}
extension Printer: BillPrinter {
    
    func printCheck(_ data: String) {
        check.printCheck(data)
    }
    
    
    func countBill(array: [PrintableItem], cachierInf: String, totalTax: Double, sum: Double) -> String {
        
        if array.isEmpty {
            return "Не было сосканировано ни одного товара"
        }
        
        var bill = String()
        
        for i in array {
            bill += ("\(i.code) \(i.name) \(i.quantity)x\(i.priceValue)\n\t\t\t\t\t\t\t\t=\(i.fullPrice)\n")
        }
        //как РАБОТАЕТ \t
        bill += "\nСУММАРНЫЙ НАЛОГ:\t\t\t    =\(totalTax)\n"
        bill += "\nПРОМЕЖУТОЧНЫЙ ИТОГ:\t\t\t    =\(sum)\n\n"
        bill += "CashMachine №1:\n\(cachierInf)\n"
        
        return bill
    }
}
    
    


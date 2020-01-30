//
//  Scanner.swift
//  CashMachine
//
//  Created by Serg on 17/03/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation

typealias ProtocolScanner = Scanner // for test

protocol Scanner {
    var scannerDeleg: ScannerDelegate {get set}
    func registration(barCode: String, name: String, price: Price, tax: TaxMode)
    func scan(barCode: String, quantity: Double)
    
}

struct Price {
    var currencyUnit: String
    var value: Double
}

enum TaxMode: Double {
    case Excise = 100
    case NDS = 0.1
}

struct RegisterableItem {
    let name: String
    let price: Price
    let tax: TaxMode
}

struct ScannableItem: Hashable {
    let code: String
    var quantity: Double
}





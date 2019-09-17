//
//  ScannerUnit.swift
//  CashMachine
//
//  Created by Serg on 17/03/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation

class ScannerUnit {
    private weak var delegate: ScannerDelegate!
}

extension ScannerUnit: Scanner {
    
    var scannerDeleg: ScannerDelegate {
        get {
            return delegate
        }
        set {
            delegate = newValue
        }
    }
    
    func registration(barCode: String, name: String, price: Price, tax: TaxMode) {
        do {
            try delegate.register(item: RegisterableItem(name: name, code: barCode, price: price, tax: tax))
        } catch {
            return
        }
    }
    
    func scan(barCode: String, quantity: Double) {
        do {
            try delegate.scan(item: ScannableItem(code: barCode, quantity: quantity))
        } catch {
            return
        }
    }
    
    
}

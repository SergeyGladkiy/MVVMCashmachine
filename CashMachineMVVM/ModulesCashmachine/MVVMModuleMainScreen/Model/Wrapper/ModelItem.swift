//
//  WrapperModel.swift
//  CashMachineApp
//
//  Created by Serg on 10/07/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation

class ModelItem {  // CashmachineModel naming
    private let model: CashMachine
    
    var showableItemsArray: Observable<[ShowableItems]> = Observable<[ShowableItems]>(observable: [])
    
    var errorOccure: Observable<String> = Observable<String>(observable: "")
    
    var readyBill: Observable<String> = Observable<String>(observable: "")
    
    init(model: CashMachine) {
        self.model = model
        model.showableItemsArray.bind { array in
            self.showableItemsArray.observable = array
        }
        model.billPrinter = Printer(check: self)
    }
}

extension ModelItem: ModelProtocol {
    func registerItem(name: String, code: String, priceCurrency: String, priceValue: Double, tax: TaxMode) {
        do {
            try model.register(item: RegisterableItem(name: name, code: code, price: Price(currencyUnit: priceCurrency, value: priceValue), tax: tax))
        } catch let error as CashmashineErrors {
            errorOccure.observable = error.localizedDescription
            print("!!!!!\(errorOccure.observable)")
            return
        } catch {
            errorOccure.observable = "ERROR"
        }
    }
    
    func scanItem(code: String, quantity: Double) {
        do {
            try model.scan(item: ScannableItem(code: code, quantity: quantity))
        } catch let error as CashmashineErrors {
            errorOccure.observable = error.localizedDescription
            return
        } catch {
            errorOccure.observable = "ERROR"
        }
    }
    
    func pay() {
        model.pay()
    }
    
    func deleteItem(index: Int) {
        model.removeScannedItem(index: index)
    }
}

extension ModelItem: MakeBill {
    func printCheck(_ data: String) {
        readyBill.observable = data
    }
}

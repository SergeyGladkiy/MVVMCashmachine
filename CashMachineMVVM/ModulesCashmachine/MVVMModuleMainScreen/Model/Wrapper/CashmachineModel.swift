//
//  WrapperModel.swift
//  CashMachineApp
//
//  Created by Serg on 10/07/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation

class CashmachineModel {  
    private unowned let model: CashMachine
    
    var dataOfItems = [ShowableItems]()
    
    var errorOccure: Observable<String> = Observable<String>(observable: "")
    
    var readyBill: Observable<String> = Observable<String>(observable: "")
    
    init(model: CashMachine) {
        self.model = model
        model.showableItemsArray.bind { array in
            self.dataOfItems = array
        }
        model.billPrinter = Printer(check: self)
    }
}

extension CashmachineModel: ModelProtocol {
    func registerItem(name: String, code: String, priceCurrency: String, priceValue: Double, tax: TaxMode) {
        do {
            try model.register(code: code, item: RegisterableItem(name: name, price: Price(currencyUnit: priceCurrency, value: priceValue), tax: tax))
        } catch let error as CashmachineErrors {
            errorOccure.observable = error.localizedDescription
            return
        } catch {
            errorOccure.observable = "ERROR"
        }
    }
    
    func scanItem(code: String, quantity: Double) {
        do {
            try model.scan(item: ScannableItem(code: code, quantity: quantity))
        } catch let error as CashmachineErrors {
            errorOccure.observable = error.localizedDescription
            return
        } catch {
            errorOccure.observable = "ERROR"
        }
    }
    
    func pay() {
        do {
            try model.pay()
        } catch let error as CashmachineErrors {
            errorOccure.observable = error.localizedDescription
            return
        } catch {
            errorOccure.observable = "ERROR"
        }
    }
    
    func deleteItem(index: Int) {
        model.removeScannedItem(index: index)
    }
    
    func changeSubscriptOfItem(from: Int, to: Int) {
        do {
            try model.motionItem(index: from, newIndex: to)
        } catch let error as CashmachineErrors {
            errorOccure.observable = error.localizedDescription
            return
        } catch {
            errorOccure.observable = "ERROR"
        }
    }
}

extension CashmachineModel: MakeBill {
    func printCheck(_ data: String) {
        readyBill.observable = data
    }
}

//
//  EntityMocker.swift
//  CashMachineAppTests
//
//  Created by Serg on 12/07/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation
@testable import CashMachineApp

class EntityMocker {
    static func generateShowableItems() -> [ShowableItems] {
        return [ShowableItems(code: "8345", quantity: 3, name: "батон Губернский", value: 70), ShowableItems(code: "2", quantity: 1, name: "Orange", value: 12), ShowableItems(code: "3", quantity: 1, name: "Meat&Co", value: 200)]
    }
    
    static func generateVMS() -> [TableViewCellViewModel] {
        let vms = generateShowableItems().map { TableViewCellViewModel(model: $0) }
        return vms
    }
    
    static func generateRegisterableItemsForRegistration() -> [String: RegisterableItem] {
        return ["8345": RegisterableItem(name: "батон Губернский", price: Price(currencyUnit: "RUB", value: 70), tax: .NDS), "2032": RegisterableItem(name: "Сервелат 350г", price: Price(currencyUnit: "RUB", value: 470), tax: .NDS), "169": RegisterableItem(name: "Водка Gradus 0.5л", price: Price(currencyUnit: "RUB", value: 400), tax: .Excise)]
    }
    
    static func generateRegisterableItem() -> [String: RegisterableItem] {
        return ["8345": RegisterableItem(name: "батон Губернский", price: Price(currencyUnit: "RUB", value: 70), tax: .NDS)]
    }
    
    static func generateKeyForRegistration() -> String {
        return "8345"
    }
    
    static func generateShowableItem() -> ShowableItems {
        return ShowableItems(code: "8345", quantity: 3, name: "батон Губернский", value: 70)
    }
    
    static func showableItems() -> ShowableItems {
        return ShowableItems(code: "8345", quantity: 3, name: "батон Губернский", value: 70)
    }
    
    static func generateScannableItem() -> ScannableItem {
        return ScannableItem(code: "8345", quantity: 3)
    }
    
    static func generateScannableItemForError() -> ScannableItem {
        return ScannableItem(code: "8346", quantity: 3)
    }
    
    static func generateTaxableItem() -> TaxableItem {
        return TaxableItem(price: 70, quantity: 3, taxes: .NDS)
    }
    
    static func generatePrintableItem() -> PrintableItem {
        return PrintableItem(code: "8345", name: "батон Губернский", quantity: 3, priceValue: 70)
    }
}

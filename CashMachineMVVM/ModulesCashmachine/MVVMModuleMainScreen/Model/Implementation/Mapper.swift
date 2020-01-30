//
//  Mapper.swift
//  CashMachine
//
//  Created by Serg on 23/03/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation

class Mapper {
    
}

extension Mapper: IMapper {
    
    func makeTaxableItems(scannedGoods: [ScannableItem], registeredGoods: [String: RegisterableItem]) throws -> [TaxableItem] {
        return try scannedGoods.map { (item) -> TaxableItem in
            guard let key = registeredGoods[item.code] else {
                throw CashmachineErrors.goodsNotFound
            }
            return TaxableItem(price: key.price.value, quantity: item.quantity, taxes: key.tax)
        }
    }
    
    func makePrintableItems(scannedGoods: [ScannableItem], registeredGoods: [String: RegisterableItem]) throws -> [PrintableItem] {
        return try scannedGoods.map { item -> PrintableItem in
            guard let key = registeredGoods[item.code] else {
                throw CashmachineErrors.goodsNotFound
            }
            return PrintableItem(code: item.code, name: key.name, quantity: item.quantity, priceValue: key.price.value)
        }
    }
    
    func makeDemonstrationItems(item: ScannableItem, registeredGoods: [String: RegisterableItem]) throws -> [ShowableItems] {
        var array = [ShowableItems]()
        guard let key = registeredGoods[item.code] else {
            throw CashmachineErrors.goodsNotFound
        }
        array.append(ShowableItems(code: item.code, quantity: item.quantity, name: key.name, value: key.price.value))
        return array
    }
    
    func performConversions(scanItems: [ScannableItem], regItems: [String: RegisterableItem]) throws -> [ShowableItems] {
        return try scanItems.map { item -> ShowableItems in
            guard let key = regItems[item.code] else {
                throw CashmachineErrors.goodsNotFound
            }
            return ShowableItems(code: item.code, quantity: item.quantity, name: key.name, value: key.price.value)
        }
    }
}

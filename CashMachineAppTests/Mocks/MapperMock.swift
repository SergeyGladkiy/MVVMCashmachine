//
//  MapperMock.swift
//  CashMachineAppTests
//
//  Created by Serg on 15/07/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation
@testable import CashMachineApp

class MapperMock: IMapper {
   
    func makeTaxableItems(scannedGoods: [ScannableItem], registeredGoods: [RegisterableItem]) -> [TaxableItem] {
        let regItem = EntityMocker.generateRegisterableItem()
        let scanItem = EntityMocker.generateScannableItem()
        if regItem.code == scanItem.code {
            switch regItem.tax {
            case .Excise:
                return [TaxableItem(price: regItem.price.value, quantity: scanItem.quantity, taxes: .Excise)]
            case .NDS:
                return [TaxableItem(price: regItem.price.value, quantity: scanItem.quantity, taxes: .NDS)]
            }
        }
        return []
    }
    
    func makePrintableItems(scannedGoods: [ScannableItem], registeredGoods: [RegisterableItem]) -> [PrintableItem] {
        let regItem = EntityMocker.generateRegisterableItem()
        let scanItem = EntityMocker.generateScannableItem()
        if regItem.code == scanItem.code {
            return [PrintableItem(code: scanItem.code, name: regItem.name, quantity: scanItem.quantity, priceValue: regItem.price.value)]
        }
        return []
    }
    
    func makeDemonstrationItems(scannedGoods: ScannableItem, registeredGoods: [RegisterableItem]) -> [ShowableItems] {
        for item in EntityMocker.generateShowableItems() {
            if scannedGoods.code == item.code {
                return [item]
            }
        }
        fatalError()
    }
    
    
}

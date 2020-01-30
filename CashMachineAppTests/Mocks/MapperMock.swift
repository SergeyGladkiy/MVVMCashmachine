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
    func makeTaxableItems(scannedGoods: [ScannableItem], registeredGoods: [String : RegisterableItem]) throws -> [TaxableItem] {
        let regItem = EntityMocker.generateRegisterableItem()
        let scanItem = EntityMocker.generateScannableItem()
        let generationItem = regItem.values.first!
        if regItem.keys.first == scanItem.code {
            switch generationItem.tax {
            case .Excise:
                return [TaxableItem(price: generationItem.price.value, quantity: scanItem.quantity, taxes: .Excise)]
            case .NDS:
                return [TaxableItem(price: generationItem.price.value, quantity: scanItem.quantity, taxes: .NDS)]
            }
        }
        fatalError()
    }
    
    func makePrintableItems(scannedGoods: [ScannableItem], registeredGoods: [String : RegisterableItem]) throws -> [PrintableItem] {
        let regItem = EntityMocker.generateRegisterableItem()
        let scanItem = EntityMocker.generateScannableItem()
        let generationItem = regItem.values.first!
        if regItem.keys.first == scanItem.code {
            return [PrintableItem(code: scanItem.code, name: generationItem.name, quantity: scanItem.quantity, priceValue: generationItem.price.value)]
        }
        fatalError()
    }
    
    func makeDemonstrationItems(item: ScannableItem, registeredGoods: [String : RegisterableItem]) throws -> [ShowableItems] {
        for generationItem in EntityMocker.generateShowableItems() {
            if item.code == generationItem.code {
                return [generationItem]
            }
        }
        fatalError()
    }
    
    func performConversions(scanItems: [ScannableItem], regItems: [String : RegisterableItem]) throws -> [ShowableItems] {
        return []
    }
}

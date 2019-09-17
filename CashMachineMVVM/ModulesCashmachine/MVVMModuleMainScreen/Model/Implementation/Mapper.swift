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
    
    func makeTaxableItems(scannedGoods: [ScannableItem], registeredGoods: [RegisterableItem]) -> [TaxableItem] {
        var arTaxableItems = [TaxableItem]()
        
        //let set: Set<[ScannableItem]> = scannedGoods
       // let array = registeredGoods.map({ let ar = TaxableItem(price: , quantity: <#T##Double#>, taxes: <#T##TaxMode#>) in return TaxableItem(price: $0.price, quantity: $0.qu, taxes: <#T##TaxMode#>)})
        for i in scannedGoods {
            for j in registeredGoods {
                if i.code == j.code {
                    switch j.tax {
                    case .Excise: arTaxableItems.append(TaxableItem(price: j.price.value, quantity: i.quantity, taxes: .Excise))
                    case .NDS: arTaxableItems.append(TaxableItem(price: j.price.value, quantity: i.quantity, taxes: .NDS))
                    }
                }
            }
        }
        return arTaxableItems
    }
    
    func makePrintableItems(scannedGoods: [ScannableItem], registeredGoods: [RegisterableItem]) -> [PrintableItem] {
        var arPrintableItems = [PrintableItem]()
        for i in scannedGoods {
            for j in registeredGoods {
                if i.code == j.code {
                    arPrintableItems.append(PrintableItem(code: i.code, name: j.name, quantity: i.quantity, priceValue: j.price.value))
                }
            }
        }
        return arPrintableItems
    }
    
    func makeDemonstrationItems(scannedGoods: ScannableItem, registeredGoods: [RegisterableItem]) -> [ShowableItems] {
        var arrayTableView = [ShowableItems]()
        for item in registeredGoods {
            if scannedGoods.code == item.code {
                arrayTableView.append(ShowableItems(code: scannedGoods.code, quantity: scannedGoods.quantity, name: item.name, value: item.price.value))
            }
        }
        return arrayTableView
    }
}

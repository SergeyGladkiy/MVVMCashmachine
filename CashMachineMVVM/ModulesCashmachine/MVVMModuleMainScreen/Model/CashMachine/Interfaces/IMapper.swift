//
//  IMapper.swift
//  CashMachine
//
//  Created by Serg on 23/03/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation

protocol IMapper {
    func makeTaxableItems(scannedGoods: [ScannableItem], registeredGoods: [RegisterableItem]) -> [TaxableItem]
    func makePrintableItems(scannedGoods: [ScannableItem], registeredGoods: [RegisterableItem]) -> [PrintableItem]
    func makeDemonstrationItems(scannedGoods: ScannableItem, registeredGoods: [RegisterableItem]) -> [ShowableItems]
}

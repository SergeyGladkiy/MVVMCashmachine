//
//  IMapper.swift
//  CashMachine
//
//  Created by Serg on 23/03/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation

protocol IMapper {
    func makeTaxableItems(scannedGoods: [ScannableItem], registeredGoods: [String: RegisterableItem]) throws -> [TaxableItem]
    func makePrintableItems(scannedGoods: [ScannableItem], registeredGoods: [String: RegisterableItem]) throws -> [PrintableItem]
    func makeDemonstrationItems(item: ScannableItem, registeredGoods: [String: RegisterableItem]) throws -> [ShowableItems]
    func performConversions(scanItems: [ScannableItem], regItems: [String: RegisterableItem]) throws -> [ShowableItems]
}

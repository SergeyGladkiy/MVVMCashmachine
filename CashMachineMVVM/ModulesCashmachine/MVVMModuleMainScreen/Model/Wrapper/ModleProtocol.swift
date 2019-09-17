//
//  IWrapperModel.swift
//  CashMachineApp
//
//  Created by Serg on 10/07/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation

protocol ModelProtocol {
    var showableItemsArray: Observable<[ShowableItems]> { get }
    var errorOccure: Observable<String> { get }
    var readyBill: Observable<String> { get }
    
    func registerItem(name: String, code: String, priceCurrency: String, priceValue: Double, tax: TaxMode)
    func scanItem(code: String, quantity: Double)
    func pay()
    func deleteItem(index: Int)
}

//
//  MainScreenViewModelType.swift
//  CashMachineApp
//
//  Created by Serg on 25/06/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation

enum ViewModelMainScreenState {
    case initial
    case printBill
    case errorHappend
    case chosenShowableItems
}

protocol MainScreenViewModelProtocol {
    var state: Observable<ViewModelMainScreenState> { get }
    var errorHappened: String { get }
    var readyBill: String { get }
    
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModel?
    func removeScannedItems(at: Int)
    func moveRow(at: Int, to: Int)
    
    func scanItem(code: String, quantity: Double)
    func registerItem(name: String, code: String, priceCurrency: String, priceValue: Double, tax: TaxMode)
    func pay()
}

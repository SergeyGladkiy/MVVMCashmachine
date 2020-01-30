//
//  Presenter.swift
//  Viper
//
//  Created by Serg on 13/04/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation

class ViewModelMainScreen {
    private unowned var model: ModelProtocol
    private var error: String!
    private var check: String!
    var state: Observable<ViewModelMainScreenState>
    
    init(state: Observable<ViewModelMainScreenState>, model: ModelProtocol) {
        self.state = state
        self.model = model
        twoWayDataBinding()
    }
}

extension ViewModelMainScreen: MainScreenViewModelProtocol {
    
    var errorHappened: String {
        return error
    }
   
    var readyBill: String {
        return check
    }
    
    func twoWayDataBinding() {
        model.errorOccure.bind { (error) in
            if error == "" {
                return
            }
            self.error = error
            self.state.observable = .errorHappend
        }
        model.readyBill.bind { (bill) in
            if bill == "" {
                return
            }
            self.check = bill
            self.state.observable = .printBill
        }
    }
    
    func registerItem(name: String, code: String, priceCurrency: String, priceValue: Double, tax: TaxMode) {
        model.registerItem(name: name, code: code, priceCurrency: priceCurrency, priceValue: priceValue, tax: tax)
    }
    
    func scanItem(code: String, quantity: Double) {
        model.scanItem(code: code, quantity: quantity)
        state.observable = .chosenShowableItems
    }
    
    func numberOfRows() -> Int {
        print(#function)
        return model.dataOfItems.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModel? {
        print(#function)
        let item = model.dataOfItems[indexPath.row]
        return TableViewCellViewModel(model: item)
    }
    
    func removeScannedItems(at: Int) {
        model.deleteItem(index: at)
        state.observable = .chosenShowableItems
    }
    
    func moveRow(at: Int, to: Int) {
        model.changeSubscriptOfItem(from: at, to: to)
    }
    
    func pay() {
        model.pay()
        state.observable = .chosenShowableItems
    }
}


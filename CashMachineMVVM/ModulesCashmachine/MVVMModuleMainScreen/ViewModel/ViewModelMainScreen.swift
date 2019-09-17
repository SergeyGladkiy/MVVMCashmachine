//
//  Presenter.swift
//  Viper
//
//  Created by Serg on 13/04/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation

class ViewModelMainScreen {
    private var modelItem: ModelProtocol!
    private var error: String!
    private var check: String!
    var state = Observable<ViewModelMainScreenState>(observable: .initial)
    
    init(state: ViewModelMainScreenState, model: ModelProtocol) {
        self.state.observable = state
        self.modelItem = model
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
        modelItem.errorOccure.bind { (error) in
            self.error = error
            self.state.observable = .errorHappend
        }
        modelItem.readyBill.bind { (bill) in
            self.check = bill
            self.state.observable = .printBill
        }
    }
    
    func registerItem(name: String, code: String, priceCurrency: String, priceValue: Double, tax: TaxMode) {
        modelItem.registerItem(name: name, code: code, priceCurrency: priceCurrency, priceValue: priceValue, tax: tax)
    }
    
    func scanItem(code: String, quantity: Double) {
        modelItem.scanItem(code: code, quantity: quantity)
        state.observable = .chosenShowableItems
    }
    
    func numberOfRows() -> Int {
        return modelItem.showableItemsArray.observable.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModel? {
        let item = modelItem.showableItemsArray.observable[indexPath.row]
        return TableViewCellViewModel(model: item)
    }
    
    func removeScannedItems(at: Int) {
        modelItem.deleteItem(index: at)
        state.observable = .chosenShowableItems
    }
    
    func pay() {
        modelItem.pay()
        state.observable = .chosenShowableItems
    }
}


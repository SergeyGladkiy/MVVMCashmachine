//
//  CashMachineMock.swift
//  CashMachineAppTests
//
//  Created by Serg on 15/07/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation
@testable import CashMachineApp

class CashMachineMock {
    var mapper: IMapper
    var showableItemsArray = Observable<[ShowableItems]>(observable: [])
    var readyBill: Observable<String> = Observable<String>(observable: "")
    var errorOccure: Observable<String> = Observable<String>(observable: "")
    
    var printingDevice: MakeBill!
    
    init(mapper: IMapper) {
        self.mapper = mapper
    }
}

extension CashMachineMock: ModelProtocol {
    var dataOfItems: [ShowableItems] {
        return showableItemsArray.observable
    }
    
    func changeSubscriptOfItem(from: Int, to: Int) {
        //
    }
    
   
    func registerItem(name: String, code: String, priceCurrency: String, priceValue: Double, tax: TaxMode) {
        for registeredItem in EntityMocker.generateRegisterableItemsForRegistration() {
            if registeredItem.key == code {
                errorOccure.observable = "товар с таким кодом уже зарегистрирован"
            }
        }
    }
    
    func scanItem(code: String, quantity: Double) {
        let scanItem = ScannableItem(code: code, quantity: quantity)
        showableItemsArray.observable.append(contentsOf: try! mapper.makeDemonstrationItems(item: scanItem, registeredGoods: [:]))
    }
    
    func pay() {
        printCheck("Chosen goods: prices")
        showableItemsArray.observable = []
        
// ------ With PrintingDeviceMock --------
//        let pd = PrintingDeviceMock { (bill) in
//            self.readyBill.observable = bill
//        }
//        pd.printCheck("Chosen goods: prices")
        
    }
    
    func deleteItem(index: Int) {
        showableItemsArray.observable = EntityMocker.generateShowableItems()
        showableItemsArray.observable.remove(at: index)
    }
}

extension CashMachineMock: MakeBill {
    func printCheck(_ data: String) {
        readyBill.observable = data
    }
}

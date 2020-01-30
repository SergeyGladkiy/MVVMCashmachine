//
//  CashMachine.swift
//  CashMachine
//
//  Created by Serg on 17/03/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation

class CashMachine {
    
    var showableItemsArray: Observable<[ShowableItems]> = Observable<[ShowableItems]>(observable: [])
    
    private var registeredGoods =  Dictionary<String, RegisterableItem>()
    private var shoplist: [ScannableItem] = []
    
    private var cashierCredentials: String
    
    private let scanner: Scanner
    private let taxCalculator: TaxCalculator
    var billPrinter: BillPrinter!
    private let mapper: IMapper
    
    init(scanner: Scanner, taxCalculator: TaxCalculator, mapper: IMapper, cashierCredentials: String) {
        self.scanner = scanner
        self.taxCalculator = taxCalculator
        self.mapper = mapper
        self.cashierCredentials = cashierCredentials
    }
    
    private func sumShopList() throws -> Double {
        var sum = 0.0
        _ = try shoplist.map {
            guard let key = registeredGoods[$0.code] else {
                throw CashmachineErrors.goodsNotFound
            }
            sum += $0.quantity * key.price.value
        }
        return sum
    }
    
    func pay() throws {
        let taxableItems = try mapper.makeTaxableItems(scannedGoods: shoplist, registeredGoods: registeredGoods)
        let printableItems = try mapper.makePrintableItems(scannedGoods: shoplist, registeredGoods: registeredGoods)
        let sumTax = taxCalculator.countTax(array: taxableItems)
        let amount = try sumShopList()
        let fullAmount = sumTax + amount
        let bill = billPrinter.countBill(array: printableItems, cachierInf: cashierCredentials, totalTax: sumTax, sum: fullAmount)
        print(bill)
        billPrinter.printCheck(bill)
        shoplist = [ScannableItem]()
        showableItemsArray.observable = []
    }
    
    func removeScannedItem(index: Int) {
        shoplist.remove(at: index)
        showableItemsArray.observable.remove(at: index)
    }
    
    func motionItem(index: Int, newIndex: Int) throws {
        let item = shoplist.remove(at: index)
        shoplist.insert(item, at: newIndex)
    }
}



extension CashMachine: ScannerDelegate {
    
    
    func register(code: String, item: RegisterableItem) throws {
        // регистрируемое проверяем в массиве зарегистрированнх
        if registeredGoods[code] == nil {
            registeredGoods[code] = item
            return
        }
        throw CashmachineErrors.registerSecondTime
    }
    
    func scan(item: ScannableItem) throws  {
        // ищем товар в отсканированных и если находим увеличиваем кол-во
        for i in 0..<shoplist.count {
            if item.code == shoplist[i].code {
                shoplist[i].quantity += item.quantity
                showableItemsArray.observable[i].quantity += item.quantity
                return
            }
        }
        
        if registeredGoods[item.code] == nil {
            throw CashmachineErrors.goodsNotFound
        }
        shoplist.append(item)
        showableItemsArray.observable += try mapper.makeDemonstrationItems(item: item, registeredGoods: registeredGoods)
    }
}



    

    

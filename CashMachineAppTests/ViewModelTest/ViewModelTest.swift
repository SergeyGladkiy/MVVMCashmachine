//
//  ViewModelTest.swift
//  CashMachineAppTests
//
//  Created by Serg on 15/07/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import XCTest
@testable import CashMachineApp

class ViewModelTest: XCTestCase {
    
    var viewModel: ViewModelMainScreen!
    var modelMock: CashMachineMock!
    
    override func setUp() {
        super.setUp()
        let mapper = MapperMock()
        modelMock = CashMachineMock(mapper: mapper)
        viewModel = ViewModelMainScreen(state: .initial, model: modelMock)
        
    }
    
    override func tearDown() {
        viewModel = nil
        modelMock = nil
        super.tearDown()
    }
    
    func testStateChosenShowableItems() {
        // given
        let item = EntityMocker.generateShowableItems().first!
        
        // when
        viewModel.scanItem(code: item.code, quantity: item.quantity)
        
        viewModel.state.bind { [weak viewModel] state in
            // then
            guard let viewModel = viewModel else {
                return
            }
            XCTAssert(state == .chosenShowableItems, "Неверный state")
            XCTAssert(viewModel.numberOfRows() == 1, "Неправильное кол-во итемов")
            XCTAssert(viewModel.cellViewModel(forIndexPath: IndexPath(row: 0, section: 0))?.description == TableViewCellViewModel(model: EntityMocker.generateShowableItem()).description, "Неверно создал ViewModel для ячейки")
        }
    }
    
    func testStatePrintBill() {
        
        //when
        viewModel.pay()
        viewModel.state.bind { [weak viewModel] state in
            guard let viewModel = viewModel else {
                return
            }
            //then
            XCTAssert(state == .chosenShowableItems, "Неверный state после функции pay")
            
            //when
            viewModel.twoWayDataBinding()
            
            //then
            XCTAssert(viewModel.state.observable == .printBill, "Неверный state после получения readyBill")
            XCTAssert(viewModel.readyBill == "Chosen goods: prices", "Неверный bill")
            
        }
    }
    
    func testStateErrorHappend() {
        //given
        let item = EntityMocker.generateRegisterableItem()
        
        //when
        viewModel.twoWayDataBinding()
        viewModel.registerItem(name: item.name, code: item.code, priceCurrency: item.price.currencyUnit, priceValue: item.price.value, tax: item.tax)
        
        viewModel.state.bind { [weak viewModel] state in
            guard let viewModel = viewModel else {
                return
            }
            //then
            XCTAssert(state == .errorHappend, "Неверный state")
            XCTAssert(viewModel.errorHappened == "товар с таким кодом уже зарегистрирован", "Неверный error")
        }
    }
    
    func testRemoveScannedItems() {
        //given
        let digitToRemove = 2
        //when
        viewModel.removeScannedItems(at: digitToRemove)
        viewModel.state.bind { [weak viewModel] state in
            guard let viewModel = viewModel else {
                return
            }
            //then
            XCTAssert(state == .chosenShowableItems, "Неверный state")
            XCTAssert(viewModel.numberOfRows() == 2, "Неправильное количество items после функции removeScannedItems")
        }
    }
}

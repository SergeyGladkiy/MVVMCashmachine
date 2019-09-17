//
//  ModelTest.swift
//  CashMachineAppTests
//
//  Created by Serg on 18/07/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import XCTest
@testable import CashMachineApp

class ModelTest: XCTestCase {
    
    var cashmachine: CashMachine!
    var mockScanner: ScannerMock!
    var mockMapper: MapperMock!
    var mockCashierCredentials: String!
    var mockCalculator: CalculatorMock!
    var mockBillPrinter: BillPrinterMock!
    var mockPrintingDevice: PrintingDeviceMock!
    var checkFromDevice: String!
    
    override func setUp() {
        super.setUp()
        let mapper = MapperMock()
        mockScanner = ScannerMock()
        mockCashierCredentials = "Tanaeva Kristina Aleksandrovna"
        mockCalculator = CalculatorMock()
        cashmachine = CashMachine(scanner: mockScanner, taxCalculator: mockCalculator, mapper: mapper, cashierCredentials: mockCashierCredentials)
        mockPrintingDevice = PrintingDeviceMock(callBack: { (check) in
            self.checkFromDevice = check
        })
        mockBillPrinter = BillPrinterMock(check: mockPrintingDevice)
        cashmachine.billPrinter = mockBillPrinter
    }
    
    override func tearDown() {
        cashmachine = nil
        mockCalculator = nil
        mockCashierCredentials = nil
        mockMapper = nil
        mockScanner = nil
        mockBillPrinter = nil
        mockPrintingDevice = nil
        checkFromDevice = nil
        super.tearDown()
    }
    
    func testPayFunction() {
        //given
        let bill = "8345 батон Губернский 3.0x70.0\n\t\t\t\t\t\t\t\t=210.0\n\nСУММАРНЫЙ НАЛОГ:\t\t\t    =21.0\n\nПРОМЕЖУТОЧНЫЙ ИТОГ:\t\t\t    =231.0\n\nCashMachine №1:\nTanaeva Kristina Aleksandrovna\n"
        
        let itemReg = EntityMocker.generateRegisterableItem()
        var errorOccur = ""
        let itemScan = EntityMocker.generateScannableItem()
        
        //when
        do {
            try cashmachine.register(item: itemReg)
        } catch {
            errorOccur = error.localizedDescription
        }
        
        do {
            try cashmachine.scan(item: itemScan)
            //then
            XCTAssert(cashmachine.showableItemsArray.observable.count == 1, "Неверное количество отсканированных item")
        } catch {
            errorOccur = error.localizedDescription
        }
        
        //when
        cashmachine.pay()
        
        //then
        XCTAssert(checkFromDevice == bill, "неверный чек")
        XCTAssert(cashmachine.showableItemsArray.observable.count == 0, "Невыполняется обнуляция showableItemsArray после pay")
    }
    
    func testRemoveScannedItem() {
        //given
        let itemReg = EntityMocker.generateRegisterableItem()
        var errorOccur = ""
        let itemScan = EntityMocker.generateScannableItem()
        
        //when
        do {
            try cashmachine.register(item: itemReg)
        } catch {
            errorOccur = error.localizedDescription
        }
        
        do {
            try cashmachine.scan(item: itemScan)
            //then
            XCTAssert(cashmachine.showableItemsArray.observable.count == 1, "Неверное количество отсканированных item")
        } catch {
            errorOccur = error.localizedDescription
        }
        
        //when
        cashmachine.removeScannedItem(index: 0)
        
        //then
        XCTAssert(cashmachine.showableItemsArray.observable.count == 0, "Неверное количество после removeScannedItem")
    }
    
    func testErrorRegistration() {
        //given
        let errorRegistration = "товар с таким кодом уже зарегистрирован"
        let itemReg = EntityMocker.generateRegisterableItem()
        var errorOccur = ""
        let itemRegTheSame = EntityMocker.generateRegisterableItem()
        
        //when
        do {
            try cashmachine.register(item: itemReg)
        } catch let error as CashmashineErrors {
            errorOccur = error.localizedDescription
        } catch {
            errorOccur = "ERROR"
        }
        
        do {
            try cashmachine.register(item: itemRegTheSame)
        } catch let error as CashmashineErrors {
            errorOccur = error.localizedDescription
            //then
            XCTAssert(errorOccur == errorRegistration, "неверная ошибка")
        } catch {
            errorOccur = "ERROR"
        }
        
    }
    
    func testErrorScan() {
        //given
        let errorScan = "код не найден в зарегистрированной базе товаров"
        let itemReg = EntityMocker.generateRegisterableItem()
        var errorOccur = ""
        let itemScan = EntityMocker.generateScannableItemForError()
        
        //when
        do {
            try cashmachine.register(item: itemReg)
        } catch let error as CashmashineErrors {
            errorOccur = error.localizedDescription
        } catch {
            errorOccur = "ERROR"
        }
        
        do {
            try cashmachine.scan(item: itemScan)
        } catch let error as CashmashineErrors {
            errorOccur = error.localizedDescription
            //then
            XCTAssert(errorScan == errorOccur, "неверная ошибка")
        } catch {
            errorOccur = "ERROR"
        }
    }
}

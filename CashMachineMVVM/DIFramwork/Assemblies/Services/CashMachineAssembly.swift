//
//  CashMachineAssembly.swift
//  CashMachineApp
//
//  Created by Serg on 26/06/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation
import Swinject

class CashMachineAssembly: Assembly {
    func assemble(container: Container) {
        container.register(TaxCalculator.self) { _ in Calculator() }
        container.register(Scanner.self) { _ in ScannerUnit() }
        container.register(IMapper.self) { _ in Mapper() }
        container.register(CashMachine.self) { r in
            let scanner = r.resolve(Scanner.self)!
            let calculator = r.resolve(TaxCalculator.self)!
            let mapper = r.resolve(IMapper.self)!
            let credentials = "Tanaeva Kristina Aleksandrovna"
            return CashMachine(scanner: scanner, taxCalculator: calculator, mapper: mapper, cashierCredentials: credentials) }.inObjectScope(.container)
    }
}

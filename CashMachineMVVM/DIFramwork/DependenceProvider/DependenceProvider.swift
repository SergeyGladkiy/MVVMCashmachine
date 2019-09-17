//
//  DependenceProvider.swift
//  CashMachineApp
//
//  Created by Serg on 02/06/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation
import Swinject

class DependenceProvider {
    private static let assembler = Assembler([ApplicationCoordinatorAssembly(), CashMachineAssembly(), MainScreenAssembly()])
    
    static func resolve<T>() -> T {
        return DependenceProvider.assembler.resolver.resolve(T.self)!
    }
}


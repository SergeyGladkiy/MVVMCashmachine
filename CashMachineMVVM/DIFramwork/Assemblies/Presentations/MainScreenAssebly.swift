//
//  MainScreenAssebly.swift
//  CashMachineApp
//
//  Created by Serg on 26/06/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation
import Swinject

class MainScreenAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(MainScreenRouterInput.self) { _ in
            CoordinatorMainScreen()
        }
        
        container.register(MainScreenViewModelProtocol.self) { r in
            let model = r.resolve(ModelProtocol.self)!
            return ViewModelMainScreen(state: Observable<ViewModelMainScreenState>(observable: .initial), model: model)
        }
        
        container.register(ModelProtocol.self) { r in
            let model = r.resolve(CashMachine.self)!
            return CashmachineModel(model: model)
        }
    }
}

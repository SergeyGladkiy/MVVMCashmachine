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
    
    //private lazy var viewModel = ViewModelMainScreen(state: .init(observable: .initial))
    
    func assemble(container: Container) {
        
        container.register(MainScreenRouterInput.self) { _ in
            CoordinatorMainScreen()
        }
//        container.register(ControllerMainScreen.self) { r in
//            let viewModel = r.resolve(MainScreenViewModelProtocol.self)!
//            return ControllerMainScreen(viewModel: viewModel)
//        }
        
        container.register(MainScreenViewModelProtocol.self) { r in
            let model = r.resolve(ModelProtocol.self)!
            return ViewModelMainScreen(state: .initial, model: model)
//            self.viewModel.wrapperModel = DependenceProvider.resolve()
//            return self.viewModel
        }
        
        container.register(ModelProtocol.self) { r in
            let model = r.resolve(CashMachine.self)!
            return ModelItem(model: model)
        }
    }
}

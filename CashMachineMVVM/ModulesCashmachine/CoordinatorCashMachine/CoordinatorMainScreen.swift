//
//  CoordinatorMainScreen.swift
//  VIPER CashMachine1
//
//  Created by Serg on 25/05/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import UIKit



class CoordinatorMainScreen {
    
}

extension CoordinatorMainScreen: MainScreenRouterInput {
    func start() -> UIViewController {
        let viewModel: MainScreenViewModelProtocol = DependenceProvider.resolve()
        let viewController = ControllerMainScreen(viewModel: viewModel)
        let navCont = UINavigationController(rootViewController: viewController)
        return navCont
    }
    
}


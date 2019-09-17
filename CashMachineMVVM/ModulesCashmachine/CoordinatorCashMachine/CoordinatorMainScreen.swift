//
//  CoordinatorMainScreen.swift
//  VIPER CashMachine1
//
//  Created by Serg on 25/05/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import UIKit

class CoordinatorMainScreen: MainScreenRouterInput {
    
    func start() -> UIViewController {
        
        //let model: ModelProtocol = DependenceProvider.resolve()
        let viewModel: MainScreenViewModelProtocol = DependenceProvider.resolve()
        //let view: ControllerMainScreen = DependenceProvider.resolve()
        let view = ControllerMainScreen(viewModel: viewModel)
        viewModel.twoWayDataBinding()
//        model.errorOccure.bind { (error) in
//            if error == "" {
//                return
//            }
//            viewModel.state.observable = .errorHappend(error)
//        }
//        model.readyBill.bind { (bill) in
//            if bill == "" {
//                return
//            }
//            viewModel.state.observable = .printBill(bill: bill)
//        }
        
        view.registeredDigits.bind { item in
            if item.code == "" {
                return
            }
            viewModel.registerItem(name: item.name, code: item.code, priceCurrency: item.priceCurrency, priceValue: item.priceValue, tax: item.tax)
        }
        view.scunnedDigits.bind { item in
            if item.code == "" {
                return
            }
            viewModel.scanItem(code: item.code, quantity: item.quantity)
        }
        

//        wrapper.showableItemsArray.bind { array in
//            ?????--------??????
//            viewModel.chosenShowableItems()
//            viewModel.state.observable = .chosenShowableItems
//        }
        
        return view
    }
}


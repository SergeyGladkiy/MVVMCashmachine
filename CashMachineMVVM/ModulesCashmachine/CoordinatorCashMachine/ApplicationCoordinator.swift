//
//  MainScreenCoordinator.swift
//  CashMachineApp
//
//  Created by Serg on 30/05/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import UIKit

class ApplicationCoordinator {
    private var window: UIWindow?
    private var coordinatorMainScreen: MainScreenRouterInput?
}

extension ApplicationCoordinator: Coordinator {
    func prepareWindow() -> UIWindow? {
        coordinatorMainScreen = DependenceProvider.resolve()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = coordinatorMainScreen!.start()
        window?.makeKeyAndVisible()
        return window
    }
}

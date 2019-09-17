//
//  ApplicationCoordinatorAssembly.swift
//  CashMachineApp
//
//  Created by Serg on 26/06/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation
import Swinject

class ApplicationCoordinatorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Coordinator.self) { _ in ApplicationCoordinator() }.inObjectScope(.container)
    }
    
    
}

//
//  TableVIewCellViewModel.swift
//  CashMachineApp
//
//  Created by Serg on 26/06/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation

class TableViewCellViewModel {
    
    let description: String
    
    init(model: ShowableItems) {
        self.description = " \(model.name): колличество \(model.quantity)"
    }
}

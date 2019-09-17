//
//  PrintingDeviceMock.swift
//  CashMachineAppTests
//
//  Created by Serg on 15/07/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation
@testable import CashMachineApp

class PrintingDeviceMock: MakeBill {
    
    private let callBack: (String)-> Void
    
    init(callBack: @escaping (String)-> Void) {
        self.callBack = callBack
    }
    
    func printCheck(_ data: String) {
        callBack(data)
    }
}

//
//  ScannerDelegate.swift
//  CashMachine
//
//  Created by Serg on 17/03/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation

protocol ScannerDelegate: class {
    func register(item: RegisterableItem) throws
    func scan(item: ScannableItem) throws
}

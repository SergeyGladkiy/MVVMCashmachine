//
//  Observable.swift
//  CashMachineApp
//
//  Created by Serg on 25/06/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import Foundation

class Observable<T> {
    var observable: T {
        didSet {
            onChanged?(observable)
        }
    }
    private var onChanged: ((T)-> Void)?
    
    init(observable: T) {
        self.observable = observable
    }
    
    func bind(bindingClosure: @escaping (T)-> Void) {
        bindingClosure(observable)
        self.onChanged = bindingClosure
    }
}

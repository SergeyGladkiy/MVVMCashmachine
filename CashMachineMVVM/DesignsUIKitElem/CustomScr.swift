//
//  CustomScr.swift
//  VIPER CashMachine1
//
//  Created by Serg on 11/05/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import UIKit

class CustomScr: UIScrollView {
    private let touchClosure: ()-> Void
    init(frame: CGRect, touchClosure: @escaping ()-> Void) {
        self.touchClosure = touchClosure
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touchClosure()
    }
}

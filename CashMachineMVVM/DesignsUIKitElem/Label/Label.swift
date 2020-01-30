//
//  Label.swift
//  lesson9(CashMachine)
//
//  Created by Serg on 11/04/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import UIKit

class Label: UILabel {
    override func layoutSubviews() {
        super.layoutSubviews()
        let desing = buildDisign()
        textColor = desing.fontTitle.fontColor
        font = font.withSize(CGFloat(desing.fontTitle.font))
        setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        
    }
    
    func buildDisign() -> ILabelDisign {
        fatalError("переопредели со своим дизайном, редиска")
    }
}



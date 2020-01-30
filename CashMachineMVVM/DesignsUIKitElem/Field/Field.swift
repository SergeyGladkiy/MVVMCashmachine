//
//  Field.swift
//  lesson9(CashMachine)
//
//  Created by Serg on 11/04/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import UIKit

class Field: UITextField {

    //  init 
    override func layoutSubviews() {
        super.layoutSubviews()
        let design = buildDesing()
        layer.cornerRadius = design.bounds.cornerRadius
        layer.borderWidth = design.bounds.borderWidth
        
        textColor = design.fontTitle.fontColor
        font = font?.withSize(CGFloat(design.fontTitle.font))
        backgroundColor = design.background.backgroundColor
        clearButtonMode = UITextField.ViewMode.unlessEditing
        
        setContentHuggingPriority(UILayoutPriority(250), for: .horizontal)

    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: bounds.origin.x + 3, dy: bounds.origin.y)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: bounds.origin.x + 3, dy: bounds.origin.y)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: bounds.origin.x + 3, dy: bounds.origin.y)
    }
    
    func buildDesing() -> IFieldDising {
        fatalError("переопредели со своим дизайном, редиска")
        
    }
}

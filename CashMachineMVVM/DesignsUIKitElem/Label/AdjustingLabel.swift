//
//  AdjustingLabel.swift
//  lesson9(CashMachine)
//
//  Created by Serg on 11/04/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import UIKit

class SettingDisingLabel: ILabelDisign {
    
    var fontTitle = Font(font: 20, fontColor: .white)
    
}

class AdjustingLabel: Label {
    override func buildDisign() -> ILabelDisign {
        return SettingDisingLabel()
    }
}




class SettingSimpleLabel: ILabelDisign {
    var fontTitle: Font = Font(font: 30, fontColor: .orange)
}

class SimpleLabel: Label {
    override func buildDisign() -> ILabelDisign {
        return SettingSimpleLabel()
    }
}

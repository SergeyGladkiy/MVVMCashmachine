//
//  GoodsTableViewCell.swift
//  VIPER CashMachine1
//
//  Created by Serg on 25/04/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import UIKit

class GoodsTableViewCell: UITableViewCell {
    
    private var arrayConstraints: [NSLayoutConstraint] = []
    
    private weak var nameLabel: UILabel!
    
    weak var viewModel: TableViewCellViewModel? {
        didSet {
            nameLabel.text = viewModel?.description
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutCell()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layoutCell()
    }
    
    
}

extension GoodsTableViewCell {
    private func layoutCell() {
        
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        let centerYLabel = label.centerYAnchor.constraint(equalTo: centerYAnchor)
        let rightLabel = label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        nameLabel = label
        
        arrayConstraints.append(contentsOf: [centerYLabel, rightLabel])
        
        NSLayoutConstraint.activate(arrayConstraints)
        
    }
}


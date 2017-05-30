//
//  YTZTagLabel.swift
//  YTZTagView
//
//  Created by Sodapig on 29/05/2017.
//  Copyright © 2017 Taozhu Ye. All rights reserved.
//

import UIKit

class YTZTagLabel: UILabel {
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initVariables()
    }
    
    private func initVariables() {
        layer.shadowColor = UIColor(white: 1, alpha: 1).cgColor
        layer.shadowOpacity = 0.5
//        layer.shadowRadius = 5
    }
}

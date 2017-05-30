//
//  YTZTagAnchorView.swift
//  YTZTagView
//
//  Created by Sodapig on 29/05/2017.
//  Copyright © 2017 Taozhu Ye. All rights reserved.
//

import UIKit

class YTZTagAnchorView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(white: 1, alpha: 1).cgColor
        layer.shadowOpacity = 0.5
//        layer.shadowRadius = 5
        startAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func startAnimation() {

    }
}

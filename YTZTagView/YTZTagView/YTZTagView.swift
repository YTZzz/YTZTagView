//
//  YTZTagView.swift
//  YTZTagView
//
//  Created by Sodapig on 29/05/2017.
//  Copyright © 2017 Taozhu Ye. All rights reserved.
//

import UIKit

class YTZTagModel {
    var name: String? = nil
    var tagId: String? = nil
    var location: CGPoint = .zero
}

enum YTZTagViewAnchorPosition {
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}

protocol YTZTagViewDelegate: class {
    func didTap(tagView: YTZTagView, tapGestureRecognizer: UITapGestureRecognizer)
}

class YTZTagView: UIView {
    
    // MARK: - Variables
    weak var delegate: YTZTagViewDelegate? = nil
    var tagModel: YTZTagModel? = nil {
        didSet {
            nameLabel.text = tagModel?.name
            nameLabel.sizeToFit()
            frame = CGRect(x: frame.minX, y: frame.minY, width: nameLabel.bounds.width + nameLabel.frame.minX * 2, height: frame.height)
            updateAnchorAndBaseLinePosition()
        }
    }
    var anchorPosition: YTZTagViewAnchorPosition = .bottomLeft {
        didSet {
            updateAnchorAndBaseLinePosition()
        }
    }
    private var lastTouchPoint: CGPoint!

    @IBOutlet weak var anchorView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var baseLineView: UIView!
    
    // MARK: - Life Cycle
    class func instanceFromNib() -> YTZTagView {
        return UINib(nibName: "YTZTagView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! YTZTagView
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        initVariables()
    }
    
    private func initVariables() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(panGesture:)))
        addGestureRecognizer(panGesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(tapGesture:)))
        addGestureRecognizer(tapGesture)
        anchorPosition = .bottomLeft
    }
    
    func show(in point: CGPoint) {
        if superview == nil {
            print("a YTZTagView instance doesn't have super view.")
            return
        }
        let anchorPointInSuperView = convert(anchorView.center, to: superview)
        let movedPoint = CGPoint(x: point.x - anchorPointInSuperView.x, y: point.y - anchorPointInSuperView.y)
        center = CGPoint(x: center.x + movedPoint.x, y: center.y + movedPoint.y)
    }
    
    private func updateAnchorAndBaseLinePosition() {
        switch anchorPosition {
        case .topLeft:
            anchorView.frame.origin = CGPoint.zero
        case .topRight:
            anchorView.frame.origin = CGPoint(x: bounds.width - anchorView.bounds.width, y: 0)
        case .bottomLeft:
            anchorView.frame.origin = CGPoint(x: 0, y: bounds.height - anchorView.bounds.height)
        case .bottomRight:
            anchorView.frame.origin = CGPoint(x: bounds.width - anchorView.bounds.width, y: bounds.height - anchorView.bounds.height)
        }
        baseLineView.frame = CGRect(x: anchorView.center.x, y: anchorView.center.y - 0.5, width: bounds.width - anchorView.bounds.width, height: 1)
    }
    
    func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        switch panGesture.state {
        case .began:
            lastTouchPoint = panGesture.location(in: panGesture.view?.superview)
        case .changed:
            fallthrough
        case .ended:
            let touchPoint = panGesture.location(in: panGesture.view?.superview)
            center = CGPoint(x: center.x + touchPoint.x - lastTouchPoint.x,
                             y: center.y + touchPoint.y - lastTouchPoint.y)
            lastTouchPoint = touchPoint
        default:
            break
        }
    }
    
    func handleTapGesture(tapGesture: UITapGestureRecognizer) {
        if delegate != nil {
            delegate?.didTap(tagView: self, tapGestureRecognizer: tapGesture)
        }
    }
}

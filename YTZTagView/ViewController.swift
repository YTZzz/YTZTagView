//
//  ViewController.swift
//  YTZTagView
//
//  Created by Sodapig on 29/05/2017.
//  Copyright © 2017 Taozhu Ye. All rights reserved.
//

import UIKit

class ViewController: UIViewController, YTZTagViewDelegate {

    @IBOutlet weak var textField: UITextField!
    var alertController: UIAlertController? = nil
    var touchedTagView: YTZTagView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertController = UIAlertController(title: nil, message: "要删除标签吗？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let confirmAction = UIAlertAction(title: "确定", style: .default, handler: {
            [weak self]
            action in
            self?.touchedTagView?.removeFromSuperview()
            self?.touchedTagView = nil
        })
        alertController?.addAction(cancelAction)
        alertController?.addAction(confirmAction)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
    }

    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        var text = textField.text
        if text?.characters.count == 0 {
            text = "This is a tag"
        }
        addTag(at: sender.location(in: sender.view), text: text!)
    }
    
    func addTag(at point: CGPoint, text: String) {
        let tagModel = YTZTagModel()
        tagModel.name = text
        let tagView = YTZTagView.instanceFromNib()
        tagView.tagModel = tagModel
        view.addSubview(tagView)
        tagView.delegate = self
        tagView.show(in: point)
    }
    
    // MARK: - YTZTagViewDelegate
    func didTap(tagView: YTZTagView, tapGestureRecognizer: UITapGestureRecognizer) {
        touchedTagView = tagView
        present(alertController!, animated: true, completion: nil)
    }

}


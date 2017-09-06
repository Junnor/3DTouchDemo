//
//  NewViewController.swift
//  3DTouch
//
//  Created by nyato on 2017/9/6.
//  Copyright © 2017年 nyato. All rights reserved.
//

import UIKit

protocol NewViewControllerDelegate: class {
    func newViewController(newViewController: NewViewController, with newItem: TableItem)
}

class NewViewController: UIViewController {
    
    weak var delegate: NewViewControllerDelegate?
    
    @IBOutlet weak var titleTextField: UITextField!

    @IBOutlet weak var detailTextField: UITextField!
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: Any) {
        titleTextField?.resignFirstResponder()
        detailTextField?.resignFirstResponder()
        
        if let title = titleTextField.text,
            let detail = detailTextField.text {
            
            let new = TableItem(title: title, detail: detail)
            delegate?.newViewController(newViewController: self, with: new)
        }
        
        dismiss(animated: true, completion: nil)        
    }
    
}

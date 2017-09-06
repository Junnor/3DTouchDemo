//
//  DetailViewController.swift
//  3DTouch
//
//  Created by nyato on 2017/9/6.
//  Copyright © 2017年 nyato. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var item: (title: String, detail: String)?  {
        didSet {
            print("item didSet")

            titleLabel?.text = item?.title
            detailLabel?.text = item?.detail
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            print("titleLabel didSet")
            
            titleLabel.text = item?.title
        }
    }

    @IBOutlet weak var detailLabel: UILabel! {
        didSet {
            print("detailLabel didSet")

            detailLabel.text = item?.detail
        }
    }
    
    // MARK: - Preview Action
    weak var fromViewController: ViewController?
    var itemIndex = 0

    override var previewActionItems: [UIPreviewActionItem] {
        
        // default style
        let show = UIPreviewAction(title: "Show", style: .default) { (action, viewController) in
            guard let sourceVC = self.fromViewController,
                let desVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
                    return
            }
            desVC.fromViewController = sourceVC
            desVC.item = self.item
            desVC.itemIndex = self.itemIndex
            
            sourceVC.show(desVC, sender: nil)
        }
        
        // selected style
        let check = UIPreviewAction(title: "selected", style: .selected) { (action, viewController) in
            
        }
        
        // delete style
        let delete = UIPreviewAction(title: "Delete", style: .destructive) { (action, viewController) in
            guard let sourceVC = self.fromViewController else { return }
            sourceVC.items.remove(at: self.itemIndex)
            sourceVC.tableView.reloadData()
        }
        
        return [show, check, delete]
    }
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("----------------------------------")
        print("viewDidLoad")
        
        title = "Content"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("viewDidAppear")
        print("----------------------------------")
    }
    
}


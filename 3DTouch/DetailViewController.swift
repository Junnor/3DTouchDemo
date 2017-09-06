//
//  DetailViewController.swift
//  3DTouch
//
//  Created by ju on 2017/9/6.
//  Copyright © 2017年 ju. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    // for dynamic shortcuts
    var share = false
    
    var item: TableItem?  {
        didSet {
            titleLabel?.text = item?.title
            detailLabel?.text = item?.detail
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = item?.title
        }
    }

    @IBOutlet weak var detailLabel: UILabel! {
        didSet {
            detailLabel.text = item?.detail
        }
    }
    
    // MARK: - Preview Action
    weak var fromViewController: ViewController?

    override var previewActionItems: [UIPreviewActionItem] {
        
        // default style
        let show = UIPreviewAction(title: "Show", style: .default) { (action, viewController) in
            guard let sourceVC = self.fromViewController,
                let desVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
                    return
            }
            
            desVC.fromViewController = sourceVC
            desVC.item = self.item
            
            sourceVC.show(desVC, sender: nil)
        }
        
        // selected style
        let check = UIPreviewAction(title: "selected", style: .selected) { (action, viewController) in
            
        }
        
        // delete style
        let delete = UIPreviewAction(title: "Delete", style: .destructive) { (action, viewController) in
            guard let sourceVC = self.fromViewController,
                let item = self.item else { return }
            TableItem.delete(item: item)
            sourceVC.tableView.reloadData()
        }
        
        return [show, check, delete]
    }
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Content"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if share {
            shareContent(self)
        }
    }
    
    // MARK: - Share 
    private var activityViewController: UIActivityViewController? {
        guard let item = item else { return nil }
        return UIActivityViewController(activityItems: [item.title, item.detail], applicationActivities: nil)
    }
    
    @IBAction func shareContent(_ sender: Any) {
        if let activityViewController = activityViewController {
            present(activityViewController, animated: true, completion: nil)
        }
    }
    
}


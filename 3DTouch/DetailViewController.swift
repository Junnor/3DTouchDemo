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


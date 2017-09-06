//
//  ViewController.swift
//  3DTouch
//
//  Created by ju on 2017/9/6.
//  Copyright © 2017年 ju. All rights reserved.
//
// Static shortcuts, set in info.plist, key as UIApplicationShortcutItems
// Dynamic shortcuts
//
//
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = 70
        }
    }
    
    // MARK: - View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "3D Touch"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    
    // MARK: - Helper
    @IBAction func newAction(_ sender: Any) {
        performSegue(withIdentifier: "new", sender: nil)
    }
        
    // MARK: - Register 3D touch
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        switch traitCollection.forceTouchCapability {
        case .available:
            print("available")
            registerForPreviewing(with: self, sourceView: tableView)
        case .unavailable:
            print("unavailable")
        case .unknown:
            print("unknown")
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to detail",
            let desvc = segue.destination as? DetailViewController,
            let indexPath = sender as? IndexPath {
            desvc.item = TableItem.all[indexPath.row]
        }
        
        if segue.identifier == "new",
            let desvc = segue.destination.targetViewController as? NewViewController {
            desvc.delegate = self
        }
        
    }
}

// MARK: - Table view dataSource & delegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableItem.all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = TableItem.all[indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.detail

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "to detail", sender: indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            TableItem.delete(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

// MARK: - Peek & Pop
extension ViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        print("viewControllerForLocation")

        guard let indexPath = tableView.indexPathForRow(at: location),
            let cell = tableView.cellForRow(at: indexPath) else {
                return nil
        }
        
        let identifier = "DetailViewController"
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: identifier) as? DetailViewController else {
            return nil
        }
        
        // for peek & pop
        detailVC.item = TableItem.all[indexPath.row]
        previewingContext.sourceRect = cell.frame
        
        // for preview action
        detailVC.fromViewController = self

        return detailVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        print("viewControllerToCommit")

        show(viewControllerToCommit, sender: self)
    }
}


//MARK: - Add new item
extension ViewController: NewViewControllerDelegate {
    func newViewController(newViewController: NewViewController, with newItem: TableItem) {
        TableItem.add(item: newItem)
    }
}


// MARK: - Get segue's destination view controller

extension UIViewController {
    
    var targetViewController: UIViewController {
        if let navc = self as? UINavigationController {
            return navc.visibleViewController ?? self
        } else {
            return self
        }
    }
}



//
//  ViewController.swift
//  3DTouch
//
//  Created by nyato on 2017/9/6.
//  Copyright © 2017年 nyato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate let items = [
    ("A", "$30"),
    ("B", "$40"),
    ("C", "$50"),
    ("D", "$60"),
    ("E", "$70")]

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = 70
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "3D Touch"
    }
    
    
    // Register  for previewing  .... 3D touch
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
    
    // Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to detail",
            let desvc = segue.destination as? DetailViewController,
            let indexPath = sender as? IndexPath {
            desvc.item = items[indexPath.row]
        }
    }
}

// MARK: - Table view dataSource & delegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.0
        cell.detailTextLabel?.text = item.1

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "to detail", sender: indexPath)
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
        
        detailVC.item = items[indexPath.row]
        previewingContext.sourceRect = cell.frame

        return detailVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        print("viewControllerToCommit")

        show(viewControllerToCommit, sender: self)
    }
}



//
//  AppDelegate.swift
//  3DTouch
//
//  Created by ju on 2017/9/6.
//  Copyright © 2017年 ju. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        TableItem.configureDynamicShortcuts()
        
        return true
    }
}

// MARK: - Home screen shortcuts
extension AppDelegate {
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        handleShortcutItem(shortcutItem: shortcutItem)
        completionHandler(true)
    }
    
    private func handleShortcutItem(shortcutItem: UIApplicationShortcutItem) {
        switch shortcutItem.type {
        case "com.ju.demo.add":
            addNewOne()
            case "com.ju.demo.share":
            share()
        default:
            break
        }
    }
    
    private func addNewOne() {
        if let newvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewViewController") as? NewViewController,
            let rootVC = window?.rootViewController?.targetViewController as? ViewController {
            newvc.delegate = rootVC
            let navc = UINavigationController(rootViewController: newvc)
            rootVC.present(navc, animated: true, completion: nil)
        }
    }
    
    private func share() {
        if let item = TableItem.all.first,
            let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController,
            let rootVC = window?.rootViewController?.targetViewController as? ViewController {
            detailVC.item = item
            detailVC.share = true
            rootVC.show(detailVC, sender: nil)
        }
    }
    
}


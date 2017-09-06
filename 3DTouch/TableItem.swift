//
//  TableItems.swift
//  3DTouch
//
//  Created by nyato on 2017/9/6.
//  Copyright © 2017年 nyato. All rights reserved.
//

import UIKit

struct TableItem {
    
    let title: String
    let detail: String
    
    static var all = [
        TableItem(title: "A", detail: "$10"),
        TableItem(title: "B", detail: "$20"),
        TableItem(title: "C", detail: "$30")
    ]
    
    static func add(item: TableItem) {
        all.append(item)
        configureDynamicShortcuts()
    }
    
    static func delete(item: TableItem) {
        if let index = all.index(where: { $0.title == item.title }) {
            all.remove(at: index)
            configureDynamicShortcuts()
        }
    }
    
    static func delete(at item: Int) {
        all.remove(at: item)
        
        configureDynamicShortcuts()
    }

    
    static func configureDynamicShortcuts() {
        if all.count > 0 {
            let shortcutType = "com.ju.demo.share"
            let shortcutItem = UIApplicationShortcutItem(type: shortcutType,
                                                         localizedTitle: "Share",
                                                         localizedSubtitle: "share content",
                                                         icon: UIApplicationShortcutIcon(type: .share),
                                                         userInfo: nil)
            UIApplication.shared.shortcutItems = [shortcutItem]
        } else {
            UIApplication.shared.shortcutItems = []
        }
    }

}

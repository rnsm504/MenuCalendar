//
//  CollectionViewItem.swift
//  MenuCalendar
//
//  Created by Masanori Kuze on 2017/08/14.
//  Copyright © 2017年 Masanori Kuze. All rights reserved.
//

import Cocoa

class CollectionViewItem: NSCollectionViewItem {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.lightGray.cgColor
        // 1
        view.layer?.borderWidth = 0.1
        // 2
        view.layer?.borderColor = NSColor.clear.cgColor  }
    
    func setHighlight(_ selected: Bool) {
        view.layer?.borderWidth = selected ? 5.0 : 5.0
    }
    

}



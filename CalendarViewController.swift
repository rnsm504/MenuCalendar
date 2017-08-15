//
//  CalendarViewController.swift
//  MenuCalendar
//
//  Created by Masanori Kuze on 2017/08/14.
//  Copyright © 2017年 Masanori Kuze. All rights reserved.
//

import Cocoa


class CalendarViewController: NSViewController, NSCollectionViewDelegate {

    
    @IBOutlet weak var calendarView: NSCollectionView!
    @IBOutlet weak var month: NSTextField!
    
    var items = Array(repeating: 0, count: 42)
    var calComps = CalComps()
    var todayComps : DateComponents?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.backgroundColors = [NSColor.clear]
        
        let date = Date()
        let calendar = Calendar.current
        todayComps = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
    }
    
    override func viewDidAppear() {
        calComps = CalComps()
        reloadView()
    }
    
    func reloadView() {
        let firstWeekDay = calComps.firstWeekDay
        let endDay = calComps.endDay
        
        items = Array(repeating: 0, count: 42)
        items[firstWeekDay] = 1
        var j : Int = 1
        for i in firstWeekDay ..< items.count {
            items[i] = j
            if(j == endDay){ break }
            j += 1
        }
        
        month.stringValue = calComps.thisMonth!
        
        calendarView.reloadData()
    }
    
    
}

extension CalendarViewController {
    @IBAction func goLeft(sender: NSButton) {
        calComps.addMonth(m: -1)
        reloadView()

    }
    
    @IBAction func goRight(sender: NSButton) {
        calComps.addMonth(m: 1)
        reloadView()
    }
    
    @IBAction func quit(sender: NSButton) {
        NSApplication.shared().terminate(sender)
    }
    
}


extension CalendarViewController : NSCollectionViewDataSource {
    
    // 1
    func numberOfSectionsInCollectionView(collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    // 2
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    // 3
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        // 4
        let item = collectionView.makeItem(withIdentifier: "CollectionViewItem", for: indexPath)
        guard let collectionViewItem = item as? CollectionViewItem else {return item}
        
        // 5
        collectionViewItem.textField?.stringValue = items[indexPath.item].description == "0" ? "" : items[indexPath.item].description
        if(items[indexPath.item] == calComps.day && todayComps?.month == calComps.month && todayComps?.year == calComps.year) {
            collectionViewItem.view.layer?.backgroundColor = NSColor.white.cgColor
        } else if(items[indexPath.item] == 0) {
            collectionViewItem.view.layer?.backgroundColor = NSColor.clear.cgColor
        } else {
            collectionViewItem.view.layer?.backgroundColor = NSColor.lightGray.cgColor
        }
        return item
    }
    
}

extension CalendarViewController : NSCollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        
        let width = collectionView.bounds.width / 7.5
        
        let size = NSSize(width: width, height: width)

        return size;
    }
    
}

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
        
        collectionViewItem.textField?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        // 日曜なら背景を変える
        let t = indexPath.item
        if(items[indexPath.item] != 0 && t % 7 == 0) {
            collectionViewItem.view.layer?.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
            collectionViewItem.textField?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
        // 土曜なら背景を変える
        if(items[indexPath.item] != 0 && t % 7 == 6) {
            collectionViewItem.view.layer?.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            collectionViewItem.textField?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
        // 祝日なら背景を変える
        if(items[indexPath.item] != 0) {
            let d : String = items[indexPath.item] >= 10 ? String(describing: items[indexPath.item]) : "0" + String(describing: items[indexPath.item])
            let m : String = calComps.month >= 10 ? String(describing: calComps.month) : "0" + String(describing: calComps.month)
            let v = m + d
            if let _ = SyukujituAry.index(of: v) {
                collectionViewItem.view.layer?.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
                collectionViewItem.textField?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
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

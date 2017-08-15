//
//  Calendar.swift
//  MenuCalendar
//
//  Created by Masanori Kuze on 2017/08/15.
//  Copyright © 2017年 Masanori Kuze. All rights reserved.
//

import Cocoa


class CalComps {
    var date : Date
    var day : Int?
    var month : Int?
    var year : Int?
    var firstWeekDay : Int = 0
    var endDay : Int = 31
    var thisMonth : String?
    
    init() {
        date = Date()
        execComps()
    }
    
    func addMonth(m : Int) {
        var comp = DateComponents()
        comp.month = m
        let calendar = Calendar.current
        date = calendar.date(byAdding: comp, to: date)!
        
        execComps()
    }
    
    private func execComps() {
        let calendar = Calendar.current
        var comps = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        day = comps.day
        month = comps.month
        year = comps.year
        
        comps.day = 1
        comps.hour = 0
        comps.minute = 0
        comps.second = 0
        let firstdate = calendar.date(from: comps)
        comps = calendar.dateComponents([.year, .month, .weekday], from: firstdate!)
        firstWeekDay = comps.weekday! - 1
        
        let mon = comps.month! > 10 ? String(describing: comps.month!) : "0" + String(describing: comps.month!)
        thisMonth = String(describing: comps.year!) + mon
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        endDay = range.upperBound - 1
    }
}


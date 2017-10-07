//
//  Calendar.swift
//  MenuCalendar
//
//  Created by Masanori Kuze on 2017/08/15.
//  Copyright © 2017年 Masanori Kuze. All rights reserved.
//

import Cocoa

public enum Syukujitu : String {
    case gantan = "0101"
    case seijinNoHi = "0109"
    case kenkokuKinenBi = "0211"
    case syunbunNoHi = "0320"
    case shouwaNoHi = "0429"
    case KenpouKinenBi = "0503"
    case midoriNoHi = "0504"
    case kodomoNoHi = "0505"
    case umiNoHi = "0717"
    case yamaNoHi = "0811"
    case keirouNoHi = "0918"
    case shunbunNoHi = "0923"
    case taikuNoHi = "1009"
    case bunkaNoHi = "1103"
    case kinrouKanshaNoHi = "1123"
    case tennoTanjoubi = "1223"
}

var SyukujituAry = ["0101", "0109", "0211", "0320", "0429", "0505", "0717", "0811", "0918", "0923", "1009", "1103", "1123", "1223"];


class CalComps {
    var date : Date = Date()
    var day : Int = 0
    var month : Int = 0
    var year : Int = 0
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
        
        day = comps.day!
        month = comps.month!
        year = comps.year!
        
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


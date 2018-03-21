//
//  NSDate-Extension.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/19.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import Foundation

extension NSDate {
    class func creatDateString(creatAtStr: String) -> String {
        //1、创建时间格式化对象
        let fmt = DateFormatter()
        fmt.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        fmt.locale = Locale(identifier: "en")
        
        //2、将字符串类型，转换成NSDate类型
        guard let creatDate = fmt.date(from: creatAtStr) else {
            return ""
        }
        
        //3、创建当前时间
        let nowDate = NSDate()
        
        //4、计算当前时间和创建时间的时间差
        let interval = Int(nowDate.timeIntervalSince(creatDate))
        
        //5、对时间间隔进行处理
        //5.1、显示刚刚
        if interval < 60 {
            return "刚刚"
        }
        
        //5.2、一小时内
        if interval < 60*60 {
            return "\(interval/60)分钟前"
        }
        
        //5.3、一天内
        if interval < 60*60*24 {
            return "\(interval/(60*60))小时前"
        }
        
        //5.4、昨天
        let calendar = Calendar.current  //创建日历对象
        if calendar.isDateInYesterday(creatDate) {
            fmt.dateFormat = "昨天 HH:mm"
            return fmt.string(from: creatDate)
        }
        
        //5.5、一年之内
        let cmps = calendar.compare(creatDate, to: nowDate as Date, toGranularity: .year)
        if cmps.rawValue < 1 {
            fmt.dateFormat = "MM-dd HH:mm"
            return fmt.string(from: creatDate)
        }
        
        //5.6、超过一年
        fmt.dateFormat = "yyyy-MM-dd HH:mm"
        return fmt.string(from: creatDate)
    }
}

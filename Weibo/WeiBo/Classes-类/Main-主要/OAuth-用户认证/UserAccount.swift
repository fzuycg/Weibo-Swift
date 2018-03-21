//
//  UserAccount.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/17.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

class UserAccount: NSObject, NSCoding {  //要对model进行归档，要准守协议NSCoding
    // MARK: 属性
    /// 授权token
    @objc var access_token: String?
    /// 过期时间 ->秒
    @objc var expires_in: Double = 0.0 {
        didSet {
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
        }
    }
    /// 用户ID
    @objc var uid: String?
    /// 过期日期
    @objc var expires_date: NSDate?
    /// 用户昵称
    @objc var screen_name: String?
    /// 用户头像地址
    @objc var avatar_large: String?
    
    // MARK: 方法
    //自定义构造函数
    init(dict: [String: AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    //重写discription属性
    override var description: String {
        //想要打印的是哪个数据就可以传哪个key
        return dictionaryWithValues(forKeys: ["access_token","expires_date","uid","screen_name","avatar_large"]).description
    }
    
    // MARK: 归档&解档
    /// 归档方法
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(expires_date, forKey: "expires_date")
        aCoder.encode(screen_name, forKey: "screen_name")
        aCoder.encode(avatar_large, forKey: "avatar_large")
    }
    
    /// 解档方法
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        uid = aDecoder.decodeObject(forKey: "uid") as? String
        expires_date = aDecoder.decodeObject(forKey: "expires_date") as? NSDate
        screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
    }
}

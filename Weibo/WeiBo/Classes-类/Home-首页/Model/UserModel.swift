//
//  UserModel.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/19.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

class UserModel: NSObject {
    //MARK:- 属性
    @objc var profile_image_url: String?        //用户头像链接
    @objc var screen_name: String?              //用户昵称
    @objc var verified_type: Int = -1           //用户认证
    @objc var mbrank:Int = 0                    //用户等级
    
    @objc var id:Int = 0                        //用户id
    @objc var description1: String?             //用户个人描述
    @objc var gender: String?                   //性别(m：男、f：女、n：未知)
    @objc var followers_count:Int = 0           //粉丝数
    @objc var friends_count:Int = 0             //关注数
    @objc var statuses_count:Int = 0            //微博数
    @objc var verified_reason: String?          //认证描述
    
    //MARK:- 自定义构造函数
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

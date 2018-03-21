//
//  StatusesModel.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/18.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

class StatusesModel: NSObject {
    //MARK:- 属性
    @objc var created_at: String?                   //微博创建时间
    @objc var source: String?                       //微博来源
    @objc var text: String?                         //微博正文
    @objc var mid: Int = 0                          //微博id
    @objc var user: UserModel?                      //微博对应用户
    @objc var pic_urls: [[String: String]]?         //微博配图数组
    @objc var retweeted_status: StatusesModel?      //微博转发的微博
    @objc var reposts_count: Int = 0                //微博转发数
    @objc var comments_count: Int = 0               //微博评论数
    @objc var attitudes_count: Int = 0              //微博点赞数
    
    
    //MARK:- 自定义构造函数
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        
        //将用户字典转成用户模型对象
        if let userDict = dict["user"] as? [String : AnyObject] {
            user = UserModel(dict:userDict)
        }
        
        //将转发微博字典转成微博模型对象
        if let retwetedStatusesDict = dict["retweeted_status"] as? [String : AnyObject] {
            retweeted_status = StatusesModel(dict:retwetedStatusesDict)
        }
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

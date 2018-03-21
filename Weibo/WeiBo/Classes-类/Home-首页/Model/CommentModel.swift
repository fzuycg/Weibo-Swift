//
//  CommentModel.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/11/14.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

class CommentModel: NSObject {
    //MARK:- 属性
    @objc var created_at: String?                   //评论创建时间
    @objc var text: String?                         //评论正文
    @objc var id: Int = 0                           //评论id
    @objc var user: UserModel?                      //评论对应用户
    
    //MARK:- 自定义构造函数
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        
        //将用户字典转成用户模型对象
        if let userDict = dict["user"] as? [String : AnyObject] {
            user = UserModel(dict:userDict)
        }
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

//
//  UserAccountViewModel.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/18.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

class UserAccountViewModel {
    // MARK: 将类设置成单例
    static let shareIntance: UserAccountViewModel = UserAccountViewModel()
    
    // MARK: 定义属性
    var account: UserAccount?
    
    // MARK: 计算属性
    var accountPath: String {
        //1.1、获取沙盒路径
        let accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
//        return (accountPath as NSString).strings(byAppendingPaths: ["account.plist"])//拼接报错
        return accountPath+"/account.plist"
    }
    
    var isLogin: Bool {
        if account == nil {
            return false
        }
        guard let expiresDate = account?.expires_date else{
            return false
        }
        return expiresDate.compare(Date()) == ComparisonResult.orderedDescending
    }
    
    // MARK: 重写init()函数
    init() {
        //1、从沙盒中读取归档信息
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserAccount
    }
    

}

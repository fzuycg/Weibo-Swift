//
//  CommentViewModel.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/11/14.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

class CommentViewModel: NSObject {
    //MARK:- 属性
    var statuses: CommentModel?
    
    //MARK:- 对数据处理后的属性
    var creatAtText: String?                    //处理创建时间
    var verifiedImage: UIImage?                 //处理用户认证图标
    var vipImage: UIImage?                      //处理用户vip图标
    var prifileUrl: URL?                        //处理用户头像地址
//    var picURLs: URL?                           //处理配图连接
    
    //MARK:- 自定义构造函数
    init(statuses: CommentModel) {
        self.statuses = statuses
        
        //1、对时间进行处理
        if let created_at = statuses.created_at, created_at != ""  {
            creatAtText = NSDate.creatDateString(creatAtStr: created_at)
        }
        
        //2、处理认证
        let verifiedType = statuses.user?.verified_type ?? -1
        switch verifiedType {  //此处认证达人认证也是0，待修改
        case 0:
            verifiedImage = UIImage(named: "认证_个人")
        case 2,3,5,7:
            verifiedImage = UIImage(named: "认证_企业")
        case 220:
            verifiedImage = UIImage(named: "认证_达人")
        default:
            verifiedImage = nil
        }
        
        //3、处理vip
        let mbrank = statuses.user?.mbrank ?? 0
        if mbrank>0 && mbrank<=7 {
            vipImage = UIImage(named: "vip_v\(mbrank)")
        } else {
            vipImage = nil
        }
        
        //4、处理头像地址
        let url = statuses.user?.profile_image_url ?? ""
        prifileUrl = URL(string: url)
        
        //6、处理配图地址
//        let picURLDicts = statuses.pic_urls?.count != 0 ? statuses.pic_urls : statuses.retweeted_status?.pic_urls
//        if let picURLDicts = picURLDicts {
//            for picURLDict in picURLDicts {
//                guard let picURLStr = picURLDict["thumbnail_pic"] else {
//                    continue
//                }
//                picURLs.append(URL(string: picURLStr)!)
//            }
//        }
        
        
    }
}

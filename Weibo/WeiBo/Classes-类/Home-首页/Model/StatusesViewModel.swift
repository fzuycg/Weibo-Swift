//
//  StatusesViewModel.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/19.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

class StatusesViewModel: NSObject {
    //MARK:- 属性
    var statuses: StatusesModel?
    
    //MARK:- 对数据处理后的属性
    var sourceText: String?                     //处理来源
    var creatAtText: String?                    //处理创建时间
    var verifiedImage: UIImage?                 //处理用户认证图标
    var vipImage: UIImage?                      //处理用户vip图标
    var prifileUrl: URL?                        //处理用户头像地址
    var picURLs: [URL] = [URL]()                //处理配图连接
    var repostsCountText: String?               //处理转发数
    var commentsCountText: String?              //处理评论数
    var attitudesCountText: String?             //处理点赞数
    
    //MARK:- 自定义构造函数
    init(statuses: StatusesModel) {
        self.statuses = statuses
        
        //1、对来源进行处理
        if let source = statuses.source, source != "" {
            //1.1、获取起始位置和截取长度
            let startIndex = (source as NSString).range(of: ">").location+1
            let length = (source as NSString).range(of: "</").location - startIndex
            
            //1.2、截取字符串
            let suorceStr = "来自"+(source as NSString).substring(with: NSRange(location: startIndex,length: length))
            sourceText = suorceStr
        }
        
        //2、对时间进行处理
        if let created_at = statuses.created_at, created_at != ""  {
            creatAtText = NSDate.creatDateString(creatAtStr: created_at)
        }
        
        //3、处理认证
        let verifiedType = statuses.user?.verified_type ?? -1
//        print("\(statuses.user?.screen_name!)->>认证等级->>\(verifiedType)")
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
        
        //4、处理vip
        let mbrank = statuses.user?.mbrank ?? 0
        if mbrank>0 && mbrank<=7 {
            vipImage = UIImage(named: "vip_v\(mbrank)")
        } else {
            vipImage = nil
        }
        
        //5、处理头像地址
        let url = statuses.user?.profile_image_url ?? ""
        prifileUrl = URL(string: url)
        
        //6、处理配图地址
        let picURLDicts = statuses.pic_urls?.count != 0 ? statuses.pic_urls : statuses.retweeted_status?.pic_urls
        if let picURLDicts = picURLDicts {
            for picURLDict in picURLDicts {
                guard let picURLStr = picURLDict["thumbnail_pic"] else {
                    continue
                }
                picURLs.append(URL(string: picURLStr)!)
            }
        }
        
        //7、处理转发/评论/点赞数
        let repostsText = statuses.reposts_count == 0 ? "转发" : "\(statuses.reposts_count)"
        let commentText = statuses.comments_count == 0 ? "评论" : "\(statuses.comments_count)"
        let attitudesText = statuses.attitudes_count == 0 ? "赞" : "\(statuses.attitudes_count)"
        repostsCountText = repostsText
        commentsCountText = commentText
        attitudesCountText = attitudesText
        
    }
}


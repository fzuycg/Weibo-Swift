//
//  NetworkingTools.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/17.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import AFNetworking

enum RequsetType {
    case GET
    case POST
}

class NetworkingTools: AFHTTPSessionManager {
    //let是线程安全的(创建单例)
    static let shareInstance : NetworkingTools = {
        let tool = NetworkingTools()
        tool.responseSerializer.acceptableContentTypes?.insert("text/html")
        return tool
    }()
}

// MARK:- 封装请求方法
extension NetworkingTools {
    func request(methodType: RequsetType, urlString: String, parameters: [String : AnyObject], finished: @escaping (_ result: Any?, _ error: Error?) -> ()) {
        
        //1、定义成功回调
        let successCallBack = { (task: URLSessionDataTask, result: Any?) in
            finished(result, nil)
        }
        
        //2、定义失败回调
        let failureCallBack = { (task: URLSessionDataTask?, error: Error) in
            finished(nil, error)
        }
        
        //3、发送网络请求
        if methodType == .GET {
            get(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        } else if methodType == .POST {
            post(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }
    }
}

// MARK:- 请求AccessToken
extension NetworkingTools {
    /// 请求token
    func loadAccessTaken(code: String, finished:@escaping (_ result: [String: AnyObject]?, _ error: Error?) -> ()) {
        let urlString = "https://api.weibo.com/oauth2/access_token"
        
        let parameters = ["client_id": app_key,"client_secret": app_secret ,"grant_type": "authorization_code" ,"code": code,"redirect_uri": redirect_url]
        
        request(methodType: .POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) in
            finished(result as? [String: AnyObject], error)
        }
    }
}

// MARK:- 请求用户信息
extension NetworkingTools {
    /// 请求用户信息
    func loadUserInfo(access_token: String, uid: String, finished:@escaping (_ result: [String: AnyObject]?, _ error: Error?) -> ()) {
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        let parameters = ["access_token": access_token,"uid": uid ]
        
        request(methodType: .GET, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) in
            finished(result as? [String: AnyObject], error)
        }
    }
}

// MARK:- 获取当前登录用户及其所关注（授权）用户的最新微博
extension NetworkingTools {
    /// 请求首页微博信息
    func loadStatuses(since_id: Int, max_id: Int, finished:@escaping (_ result: [[String: AnyObject]]?, _ error: Error?) -> ()) {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        let access_token = (UserAccountViewModel.shareIntance.account?.access_token)!
        let parameters = ["access_token": access_token, "since_id": "\(since_id)", "max_id": "\(max_id)"]
        request(methodType: .GET, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) in
            //1、获取字典数据
            guard let resultDict = result as? [String: AnyObject] else {
                finished(nil, error)
                return
            }
            
            //2、将数组数据回调
            finished(resultDict["statuses"] as? [[String: AnyObject]], error)
        }
    }
}


// MARK:- 获取指定微博的评论列表
extension NetworkingTools {
    /// 请求微博评论
    func loadComments(since_id: Int, finished:@escaping (_ result: [[String: AnyObject]]?, _ error: Error?) -> ()) {
        let urlString = "https://api.weibo.com/2/comments/show.json"
        
        let access_token = (UserAccountViewModel.shareIntance.account?.access_token)!
        let parameters = ["access_token": access_token, "id": "\(since_id)"]
        request(methodType: .GET, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) in
            //1、获取字典数据
            guard let resultDict = result as? [String: AnyObject] else {
                finished(nil, error)
                return
            }
            
            //2、将数组数据回调
            finished(resultDict["statuses"] as? [[String: AnyObject]], error)
        }
    }
}

// MARK:- 请求用户粉丝列表
extension NetworkingTools {
    /// 请求粉丝列表
    func loadFollowers(uid: Int, finished:@escaping (_ result: [[String: AnyObject]]?, _ error: Error?) -> ()) {
        let urlString = "https://api.weibo.com/2/friendships/followers.json"
        
        let access_token = (UserAccountViewModel.shareIntance.account?.access_token)!
        
        let parameters = ["access_token": access_token, "uid": "\(uid)"]
        
        request(methodType: .GET, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) in
            //1、获取字典数据
            guard let resultDict = result as? [String: AnyObject] else {
                finished(nil, error)
                return
            }
            
            //2、将数组数据回调
            finished(resultDict["users"] as? [[String: AnyObject]], error)
        }
    }
}

// MARK:- 请求用户关注列表
extension NetworkingTools {
    /// 请求关注列表
    func loadFrieds(uid: Int, finished:@escaping (_ result: [[String: AnyObject]]?, _ error: Error?) -> ()) {
        let urlString = "https://api.weibo.com/2/friendships/friends.json"
        
        let access_token = (UserAccountViewModel.shareIntance.account?.access_token)!
        
        let parameters = ["access_token": access_token, "uid": "\(uid)"]
        
        request(methodType: .GET, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) in
            //1、获取字典数据
            guard let resultDict = result as? [String: AnyObject] else {
                finished(nil, error)
                return
            }
            
            //2、将数组数据回调
            finished(resultDict["users"] as? [[String: AnyObject]], error)
        }
    }
}




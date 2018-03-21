//
//  OAuthViewController.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/17.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthViewController: UIViewController {
    // MARK:- 连线属性
    @IBOutlet weak var webView: UIWebView!
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //1、设置导航栏
        setupNavigationBar()
        
        //2、加载网页
        loadPage()
    }
}

// MARK:- 设置UI界面
extension OAuthViewController {
    /// 设置导航栏
    private func setupNavigationBar() {
        //1、设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(OAuthViewController.closeItemClick))
        
        //2、设置右侧的Item
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(OAuthViewController.fillItemClick))
        
        //3、设置标题
        title = "登录页面"
        
    }
    
    /// 加载网页
    private func loadPage() {
        //1、创建登录页面的URLString
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_url)"
        
        //2、创建对应的NSURL
        guard let url = URL(string: urlString) else {
            return
        }
        
        //3、创建URLRequest对象
        let request = URLRequest(url: url)
        
        //4、加载request对象
        webView.loadRequest(request as URLRequest)
    }
}

// MARK:- 事件监听
extension OAuthViewController {
    @objc private func closeItemClick() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func fillItemClick() {
        //1、书写JS代码
        let jsCode = "document.getElementById('userId').value='123';document.getElementById('passwd').value='000000';"
        
        //2、执行JS代码
        webView.stringByEvaluatingJavaScript(from: jsCode)
    }
}

// MARK:- webView的代理方法
extension OAuthViewController: UIWebViewDelegate {
    //webView开始加载网页
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    //webView加载网页完成
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    //webView加载失败
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    
    //当准备开始加载某个页面时，执行该方法
    //返回值：ture->继续加载该页面 false->不会加载该页面
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        //1、获取加载的NSURL
        guard let url = request.url else {
            return true
        }
        
        //2、获取url中的字符串
        let urlString = url.absoluteString
        
        //3、判断该字符串中是否包含有code
        guard urlString.contains("code=") else {
            return true
        }
        
        //4、将code截取出来
        let code = urlString.components(separatedBy: "code=").last!
        
        //5、请求accessToken
        loadAccessTolen(code: code)
        
        return false
    }
}


// MARK:- 请求数据
extension OAuthViewController {
    /// 请求AccessTaken
    private func loadAccessTolen(code: String) {
        NetworkingTools.shareInstance.loadAccessTaken(code: code) { (result, error) in
            //1、错误校验
            if error != nil {
                print(error!)
                return
            }
            
            //2、拿到数据
            guard let accountDic = result else {
                return
            }
            
            //3、字典转成模型
            let account = UserAccount(dict: accountDic)
            
            //4、请求用户信息
            self.loadUserInfo(account: account)
        }
    }
    
    /// 请求用户信息
    private func loadUserInfo(account: UserAccount) {
        //1、获取token
        guard let accessToken = account.access_token else {
            return
        }
        
        //2、获取uid
        guard let uid = account.uid else {
            return
        }
        
        //3、进行网络请求
        NetworkingTools.shareInstance.loadUserInfo(access_token:  accessToken, uid: uid) { (result, error) in
            //1、进行错误校验
            if error != nil {
                print(error!)
                return
            }
            //2、拿到用户信息
            guard let userInfoDict = result else {
                return
            }
            
            //3、从字典中取出昵称与头像地址
            account.screen_name = userInfoDict["screen_name"] as? String
            account.avatar_large = userInfoDict["avatar_large"] as? String
            
            //4、将account进行保存
            NSKeyedArchiver.archiveRootObject(account, toFile: UserAccountViewModel.shareIntance.accountPath)
            
            //5、将account对象设置到单例对象中
            UserAccountViewModel.shareIntance.account = account
            
            //6、退出当前控制器
            self.dismiss(animated: false, completion: {
                UIApplication.shared.keyWindow?.rootViewController = WelcomeViewController()
            })
        }
        
    }
}

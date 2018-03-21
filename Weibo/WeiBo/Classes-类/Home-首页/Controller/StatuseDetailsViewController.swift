//
//  StatuseDetailsViewController.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/11/17.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit
import SVProgressHUD

class StatuseDetailsViewController: UIViewController {
    // MARK:- 连线属性
    @IBOutlet weak var webView: UIWebView!
    
    // MARK:- 设置属性
    var id: Int = 0

    // MARK: -系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        loadPage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if SVProgressHUD.isVisible() {
            SVProgressHUD.dismiss()
        }
    }

}

// MARK:- 设置UI界面
extension StatuseDetailsViewController {
    /// 设置导航栏
    private func setupNavigationBar() {
        
    }
    
    /// 加载页面
    private func loadPage() {
        //1、创建页面的URLString
        let urlString = "http://api.weibo.com/2/statuses/go?access_token=\(UserAccountViewModel.shareIntance.account?.access_token! ?? "")&uid=\(UserAccountViewModel.shareIntance.account?.uid ?? "")&id=\(id)"
        
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

// MARK:- webView的代理方法
extension StatuseDetailsViewController: UIWebViewDelegate {
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
}


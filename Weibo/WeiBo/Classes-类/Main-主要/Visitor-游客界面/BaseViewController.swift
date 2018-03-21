//
//  BaseViewController.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/13.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

class BaseViewController: UITableViewController {
    
    lazy var visitorView: VisitorView = VisitorView.visitorView()
    
    var isLogin: Bool = UserAccountViewModel.shareIntance.isLogin
    
    //系统回调函数
    override func loadView() {
        
        //判断要加载View
        isLogin ? super.loadView() : setupVisitorView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

// MARK:- UI设置
extension BaseViewController {
    /// 设置访客视图
    private func setupVisitorView() {
        view = visitorView
        
        visitorView.registerBtn.layer.cornerRadius = 3
        visitorView.registerBtn.addTarget(self, action: #selector(BaseViewController.registerBtnClick), for: .touchUpInside)
        visitorView.loginBtn.layer.cornerRadius = 3
        visitorView.loginBtn.addTarget(self, action: #selector(BaseViewController.loginBtnClick), for: .touchUpInside)
        
        setupNavItems()
    }
    
    /// 设置导航栏的注册登录按钮
    func setupNavItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(BaseViewController.registerBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(BaseViewController.loginBtnClick))
    }
    
}

// MARK:- 按钮响应事件
extension BaseViewController {
    /// 注册事件
    @objc private func registerBtnClick() {
        print("点击了注册按钮")
    }
    
    /// 登录事件
    @objc private func loginBtnClick() {
        //1、创建授权控制器
        let oauthVC = OAuthViewController()
        
        //2、包装导航栏控制器
        let oauthNav = UINavigationController(rootViewController: oauthVC)
        
        //3、弹出控制器
        present(oauthNav, animated: true, completion: nil)
    }
}
